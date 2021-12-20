#ifndef STARS_INCLUDED
#define STARS_INCLUDED

float hash13(float3 p3)
{
	p3  = frac(p3 * .1031);
    p3 += dot(p3, p3.zyx + 31.32);
    return frac((p3.x + p3.y) * p3.z);
}

float renderStars(const float3 pos)
{
    float3 p = floor((abs(normalize(pos)) + 16.0) * 265.0);

    float stars = smoothstep(0.9975, 1.0, hash13(p));

    return stars;
}

#endif /* !STARS_INCLUDED */