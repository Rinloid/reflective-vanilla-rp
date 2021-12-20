#ifndef CLOUDS_INCLUDED
#define CLOUDS_INCLUDED

float hash12(float2 p)
{
	float3 p3  = frac(float3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return frac((p3.x + p3.y) * p3.z);
}

float render2DClouds(const float2 pos, const float time)
{
    float2 p = pos;
    p.x += time * 0.02;
    float body = hash12(floor(p));
    body = (body > 0.85) ? 1.0 : 0.0;

    return body;
}

float2 renderThickClouds(const float3 pos, const float time)
{
#if CLOUD_TYPE == 1
    static const int steps = 1;
    static const float stepSize = 0.032;
#elif CLOUD_TYPE == 2
    static const int steps = 6;
    static const float stepSize = 0.016;
#elif CLOUD_TYPE == 3
    static const int steps = 12;
    static const float stepSize = 0.008;
#endif

float clouds = 0.0;
float cHeight = 0.0;
    for (int i = 0; i < steps; i++)
    {
        float height = 1.0 + float(i) * stepSize;
        float2 cloudPos = pos.xz / pos.y * height;
        cloudPos *= 2.5;
        clouds += render2DClouds(cloudPos, time);
        #if CLOUD_TYPE != 1
            if (i == 0) {
                cHeight = render2DClouds(cloudPos, time);
            }
        #endif
    }
clouds = clouds > 0.0 ? 1.0 : 0.0;

return float2(clouds, cHeight);
}

#endif /* !CLOUDS_INCLUDED */