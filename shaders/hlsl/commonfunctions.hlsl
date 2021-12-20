#ifndef SHADERFUNCTIONS_INCLUDED
#define SHADERFUNCTIONS_INCLUDED

// https://github.com/origin0110/OriginShader
float getTime(const float4 fogCol) {
	return fogCol.g > 0.213101 ? 1.0 : 
		dot(float4(fogCol.g * fogCol.g * fogCol.g, fogCol.g * fogCol.g, fogCol.g, 1.0), 
			float4(349.305545, -159.858192, 30.557216, -1.628452));
}

float rgb2luma(float3 color) {
    return dot(color, float3(0.22, 0.707, 0.071));
}

#endif /* !SHADERFUNCTIONS_INCLUDED */