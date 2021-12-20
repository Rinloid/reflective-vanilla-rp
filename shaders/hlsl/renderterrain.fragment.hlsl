#include "ShaderConstants.fxh"
#include "util.fxh"

struct PS_Input
{
	float4 position : SV_Position;
	float3 cameraPosition : cameraPosition;
	float3 worldPosition : worldPosition;
	bool isWater : isWater;

#ifndef BYPASS_PIXEL_SHADER
	lpfloat4 color : COLOR;
	snorm float2 uv0 : TEXCOORD_0_FB_MSAA;
	snorm float2 uv1 : TEXCOORD_1_FB_MSAA;
#endif

#ifdef FOG
	float fogFactor : fogFactor;
#endif
};

struct PS_Output
{
	float4 color : SV_Target;
};

#include "preset.hlsl"
#include "commonfunctions.hlsl"
#include "stars.hlsl"
#include "sun_moon.hlsl"
#include "clouds.hlsl"

ROOT_SIGNATURE
void main(in PS_Input PSInput, out PS_Output PSOutput)
{
#ifdef BYPASS_PIXEL_SHADER
    PSOutput.color = float4(0.0f, 0.0f, 0.0f, 0.0f);
    return;
#else

#ifdef BLEND
	static const bool isBlend = true;
#else
	static const bool isBlend = false;
#endif

float3 worldNormal = 
#ifdef FANCY
	normalize(cross(ddx(-PSInput.worldPosition), ddy(PSInput.worldPosition)));
#else
	float3(0, 1, 0);
#endif
float3 reflectPos = reflect(normalize(PSInput.cameraPosition), worldNormal);
float reflectance = 0.0;
if (PSInput.isWater)
{
	reflectance = WATER_REFLECTANCE;
} else if (isBlend)
{
	reflectance = ALPHA_BLENDED_BLOCKS_REFLECTANCE;
}

float time = getTime(FOG_COLOR);
float daylight = max(0.0, time);
float set = min(smoothstep(0.0, 0.2, time), smoothstep(0.6, 0.3, time));
float nether = 
#ifdef FOG
	FOG_CONTROL.x / FOG_CONTROL.y;
	nether = step(0.1, nether) - step(0.12,nether);
#else
	0.0;
#endif
float underwater =
#ifdef FOG
	step(FOG_CONTROL.x, 0.0);
#else
	0.0;
#endif
float rain = 
#ifdef FOG
	lerp(smoothstep(0.5, 0.3, FOG_CONTROL.x), 0.0, underwater);
#else
	0.0;
#endif

#if USE_TEXEL_AA
	float4 diffuse = texture2D_AA(TEXTURE_0, TextureSampler0, PSInput.uv0 );
#else
	float4 diffuse = TEXTURE_0.Sample(TextureSampler0, PSInput.uv0);
#endif

#ifdef SEASONS_FAR
	diffuse.a = 1.0f;
#endif

#if USE_ALPHA_TEST
	#ifdef ALPHA_TO_COVERAGE
		#define ALPHA_THRESHOLD 0.05
	#else
		#define ALPHA_THRESHOLD 0.5
	#endif
	if(diffuse.a < ALPHA_THRESHOLD)
		discard;
#endif

#if defined(BLEND)
	diffuse.a *= PSInput.color.a;
#endif

#if !defined(ALWAYS_LIT)
	diffuse = diffuse * TEXTURE_1.Sample(TextureSampler1, PSInput.uv1);
#endif

#ifndef SEASONS
	#if !USE_ALPHA_TEST && !defined(BLEND)
		diffuse.a = PSInput.color.a;
	#endif	

	diffuse.rgb *= PSInput.color.rgb;
#else
	float2 uv = PSInput.color.xy;
	diffuse.rgb *= lerp(1.0f, TEXTURE_2.Sample(TextureSampler2, uv).rgb*2.0f, PSInput.color.b);
	diffuse.rgb *= PSInput.color.aaa;
	diffuse.a = 1.0f;
#endif

if ((PSInput.isWater || isBlend) && !bool(underwater))
{
float3 skyPos = reflectPos;
float3 reflectedCol = float3(1.0, 1.0, 1.0);
float3 sunMoonPos = (time > 0.0 ? 1.0 : -1.0) * float3(cos(time), sin(time), 0.0);

#include "renderreflectedview.hlsl"

reflectedCol = lerp(diffuse.rgb, reflectedCol, smoothstep(0.4, 1.0, PSInput.uv1.y));

diffuse.rgb = lerp(diffuse.rgb, reflectedCol.rgb, reflectance);
}

#ifdef FOG
	float3 fogColor = lerp(lerp(nightFogCol, dayFogCol, daylight), setFogCol, set);
	fogColor = lerp(fogColor, rgb2luma(fogColor), rain);
	if (bool(underwater) || bool(nether))
	{
		fogColor = FOG_COLOR.rgb;
	}
	diffuse.rgb = lerp( diffuse.rgb, fogColor, PSInput.fogFactor );
#endif

	PSOutput.color = diffuse;

#ifdef VR_MODE
	// On Rift, the transition from 0 brightness to the lowest 8 bit value is abrupt, so clamp to 
	// the lowest 8 bit value.
	PSOutput.color = max(PSOutput.color, 1 / 255.0f);
#endif

#endif // BYPASS_PIXEL_SHADER
}