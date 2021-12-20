#ifndef SUN_MOON_INCLUDED
#define SUN_MOON_INCLUDED

float renderSquare(const hmp vec3 pos, const float size)
{
    vec3 p = abs(pos) * size;
    float shape = 1.0 - max(max(p.x, p.z), p.y);

    return step(0.0, shape);
}

vec3 renderSunMoon(const hmp vec3 pos, const vec3 sunMoonPos)
{
    hmp vec3 p = cross(normalize(pos), sunMoonPos);
    float inner = renderSquare(p, 16.0);
    float outer = renderSquare(p, 12.0);
    p *= 8.0;
    p = floor(p / 0.12) * 0.12;
    float halo = min(1.0, inversesqrt(p.x * p.x + p.y * p.y + p.z * p.z));
    
    return vec3(inner, outer, halo);
}

#endif /* !SUN_MOON_INCLUDED */