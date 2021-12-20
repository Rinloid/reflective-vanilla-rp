#ifndef CLOUDS_INCLUDED
#define CLOUDS_INCLUDED

// https://www.shadertoy.com/view/4djSRW
hmp float hash12(hmp vec2 p)
{
	hmp vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float render2DClouds(const hmp vec2 pos, const hmp float time)
{
    vec2 p = pos;
    p.x += time * 0.02;
    float body = hash12(floor(p));
    body = (body > 0.85) ? 1.0 : 0.0;

    return body;
}

vec2 renderThickClouds(const hmp vec3 pos, const hmp float time)
{
#if CLOUD_TYPE == 1
    const int steps = 1;
    const float stepSize = 0.032;
#elif CLOUD_TYPE == 2
    const int steps = 6;
    const float stepSize = 0.016;
#elif CLOUD_TYPE == 3
    const int steps = 12;
    const float stepSize = 0.008;
#endif

float clouds = 0.0;
float cHeight = 0.0;
    for (int i = 0; i < steps; i++)
    {
        float height = 1.0 + float(i) * stepSize;
        hmp vec2 cloudPos = pos.xz / pos.y * height;
        cloudPos *= 2.5;
        clouds += render2DClouds(cloudPos, time);
        #if CLOUD_TYPE != 1
            if (i == 0) {
                cHeight = render2DClouds(cloudPos, time);
            }
        #endif
    }
clouds = clouds > 0.0 ? 1.0 : 0.0;

return vec2(clouds, cHeight);
}

#endif /* !CLOUDS_INCLUDED */