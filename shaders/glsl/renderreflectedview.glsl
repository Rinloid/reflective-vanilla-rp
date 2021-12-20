#ifndef RENDERREFLECTEDVIEW_INCLUDED
#define RENDERREFLECTEDVIEW_INCLUDED

vec3 skyCol = mix(mix(nightSkyCol, daySkyCol, daylight), setSkyCol, set);
vec3 sunCol = skyCol;
vec3 moonCol = skyCol;
vec3 sunHaloCol = mix(mix(nightSunHaloCol, daySunHaloCol, daylight), setSunHaloCol, set);
vec3 sunInnerCol = mix(mix(nightSunInnerCol, daySunInnerCol, daylight), setSunInnerCol, set);
vec3 sunOuterCol = mix(mix(nightSunOuterCol, daySunOuterCol, daylight), setSunOuterCol, set);
vec3 moonDiffuseCol = mix(mix(nightMoonDiffuseCol, dayMoonDiffuseCol, daylight), setMoonDiffuseCol, set);
vec3 moonInnerCol = mix(mix(nightMoonInnerCol, dayMoonInnerCol, daylight), setMoonInnerCol, set);
vec3 moonOuterCol = mix(mix(nightMoonOuterCol, dayMoonOuterCol, daylight), setMoonOuterCol, set);
vec3 fogCol = mix(mix(nightFogCol, dayFogCol, daylight), setFogCol, set);
vec2 clouds = vec2(0.0, 0.0);

float drawSpace = smoothstep(0.0, 1.0, length(skyPos.xz / (skyPos.y * float(CLOUD_RENDER_DISTANCE))));

#ifdef ENABLE_CLOUDS
    if (drawSpace < 1.0 && !bool(step(skyPos.y, 0.0)))
    {
        clouds = renderThickClouds(skyPos, TOTAL_REAL_WORLD_TIME);
        clouds = mix(vec2(0.0, 0.0), clouds, smoothstep(0.0, 0.016, skyPos.y));
        clouds = mix(clouds, vec2(0.0, 0.0), drawSpace);
    }
#endif

vec3 cloudCol = mix(mix(nightCloudCol, dayCloudCol, daylight), setCloudCol, set);
vec3 cloudShadowCol = mix(mix(nightCloudShadowCol, dayCloudShadowCol, daylight), setCloudShadowCol, set);

skyCol = mix(skyCol, fogCol, smoothstep(0.8, 1.0, 1.0 - skyPos.y));
skyCol = mix(skyCol, vec3(rgb2luma(skyCol)), rain);

reflectedCol = skyCol;

#ifdef ENABLE_STARS
    float stars = renderStars(skyPos);

    stars = mix(0.0, stars, smoothstep(1.0, 0.95, daylight));
    stars = mix(stars, 0.0, rain);
    reflectedCol = mix(reflectedCol, vec3(1.0, 1.0, 1.0), stars);
#endif

if (daylight > 0.0)
{
    #ifdef ENABLE_SUN
        vec3 sun = renderSunMoon(skyPos, sunMoonPos);
        sun = mix(sun, vec3(0.0, 0.0, 0.0), rain);

        sunCol = mix(sunCol, sunHaloCol, sun.z * 0.8);
        sunCol = mix(sunCol, sunOuterCol, sun.y);
        sunCol = mix(sunCol, sunInnerCol, sun.x);

        reflectedCol = mix(reflectedCol, sunCol, sun.z);
    #endif
} else
{
    #ifdef ENABLE_MOON
        vec3 moon = renderSunMoon(skyPos, sunMoonPos);
        moon = mix(moon, vec3(0.0, 0.0, 0.0), rain);

        moonCol = mix(moonCol, moonDiffuseCol, moon.z * 0.8);
        moonCol = mix(moonCol, moonOuterCol, moon.y);
        moonCol = mix(moonCol, moonInnerCol, moon.x);

        reflectedCol = mix(reflectedCol, moonCol, moon.z);
#endif
}

#ifdef CLOUD_TYPE
    cloudCol = mix(cloudCol, cloudShadowCol, clouds.y);
    cloudCol = mix(cloudCol, skyCol, drawSpace);
    cloudCol = mix(cloudCol, vec3(rgb2luma(cloudCol)), rain);

    reflectedCol = mix(reflectedCol, cloudCol, clouds.x);
#endif

#endif /* !RENDERREFLECTEDVIEW_INCLUDED */