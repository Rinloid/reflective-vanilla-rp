#include "ShaderConstants.fxh"
#include "util.fxh"

struct PS_Input
{
    float4 position : SV_Position;
    float3 skyPosition : skyPosition;
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

float4 diffuse = float4(1.0, 1.0, 1.0, 1.0);
float3 skyPos = PSInput.skyPosition;
float3 reflectedCol = float3(1.0, 1.0, 1.0);
float time = getTime(FOG_COLOR);
float3 sunMoonPos = (time > 0.0 ? 1.0 : -1.0) * float3(cos(time), sin(time), 0.0);
float daylight = max(0.0, time);
float set = min(smoothstep(0.0, 0.2, time), smoothstep(0.6, 0.3, time));
float rain = lerp(smoothstep(0.5, 0.3, FOG_CONTROL.x), 0.0, step(FOG_CONTROL.x, 0.0));

#include "renderreflectedview.hlsl"

diffuse.rgb = reflectedCol.rgb;

PSOutput.color = diffuse;

}
