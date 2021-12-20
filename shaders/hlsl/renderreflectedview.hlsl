#ifndef RENDERREFLECTEDVIEW_INCLUDED
#define RENDERREFLECTEDVIEW_INCLUDED

float3 skyCol = lerp(lerp(nightSkyCol, daySkyCol, daylight), setSkyCol, set);
float3 sunCol = skyCol;
float3 moonCol = skyCol;
float3 sunHaloCol = lerp(lerp(nightSunHaloCol, daySunHaloCol, daylight), setSunHaloCol, set);
float3 sunInnerCol = lerp(lerp(nightSunInnerCol, daySunInnerCol, daylight), setSunInnerCol, set);
float3 sunOuterCol = lerp(lerp(nightSunOuterCol, daySunOuterCol, daylight), setSunOuterCol, set);
float3 moonDiffuseCol = lerp(lerp(nightMoonDiffuseCol, dayMoonDiffuseCol, daylight), setMoonDiffuseCol, set);
float3 moonInnerCol = lerp(lerp(nightMoonInnerCol, dayMoonInnerCol, daylight), setMoonInnerCol, set);
float3 moonOuterCol = lerp(lerp(nightMoonOuterCol, dayMoonOuterCol, daylight), setMoonOuterCol, set);
float3 fogCol = lerp(lerp(nightFogCol, dayFogCol, daylight), setFogCol, set);
float2 clouds = float2(0.0, 0.0);

float drawSpace = smoothstep(0.0, 1.0, length(skyPos.xz / (skyPos.y * float(CLOUD_RENDER_DISTANCE))));

#ifdef ENABLE_CLOUDS
    if (drawSpace < 1.0 && !bool(step(skyPos.y, 0.0)))
    {
        clouds = renderThickClouds(skyPos, TOTAL_REAL_WORLD_TIME);
        clouds = lerp(float2(0.0, 0.0), clouds, smoothstep(0.0, 0.016, skyPos.y));
        clouds = lerp(clouds, float2(0.0, 0.0), drawSpace);
    }
#endif

float3 cloudCol = lerp(lerp(nightCloudCol, dayCloudCol, daylight), setCloudCol, set);
float3 cloudShadowCol = lerp(lerp(nightCloudShadowCol, dayCloudShadowCol, daylight), setCloudShadowCol, set);

skyCol = lerp(skyCol, fogCol, smoothstep(0.8, 1.0, 1.0 - skyPos.y));
skyCol = lerp(skyCol, rgb2luma(skyCol), rain);

reflectedCol = skyCol;

#ifdef ENABLE_STARS
    float stars = renderStars(skyPos);

    stars = lerp(0.0, stars, smoothstep(1.0, 0.95, daylight));
    stars = lerp(stars, 0.0, rain);
    reflectedCol = lerp(reflectedCol, float3(1.0, 1.0, 1.0), stars);
#endif

if (daylight > 0.0)
{
    #ifdef ENABLE_SUN
        float3 sun = renderSunMoon(skyPos, sunMoonPos);
        sun = lerp(sun, float3(0.0, 0.0, 0.0), rain);

        sunCol = lerp(sunCol, sunHaloCol, sun.z * 0.8);
        sunCol = lerp(sunCol, sunOuterCol, sun.y);
        sunCol = lerp(sunCol, sunInnerCol, sun.x);

        reflectedCol = lerp(reflectedCol, sunCol, sun.z);
    #endif
} else
{
    #ifdef ENABLE_MOON
        float3 moon = renderSunMoon(skyPos, sunMoonPos);
        moon = lerp(moon, float3(0.0, 0.0, 0.0), rain);

        moonCol = lerp(moonCol, moonDiffuseCol, moon.z * 0.8);
        moonCol = lerp(moonCol, moonOuterCol, moon.y);
        moonCol = lerp(moonCol, moonInnerCol, moon.x);

        reflectedCol = lerp(reflectedCol, moonCol, moon.z);
#endif
}

#ifdef CLOUD_TYPE
    cloudCol = lerp(cloudCol, cloudShadowCol, clouds.y);
    cloudCol = lerp(cloudCol, skyCol, drawSpace);
    cloudCol = lerp(cloudCol, rgb2luma(cloudCol), rain);

    reflectedCol = lerp(reflectedCol, cloudCol, clouds.x);
#endif

#endif /* !RENDERREFLECTEDVIEW_INCLUDED */