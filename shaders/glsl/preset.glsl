#ifndef PRESET_INCLUDED
#define PRESET_INCLUDED
// ^ don't delete them.





/* Preset file of Reflective Vanilla Shaders */

// 1: fast (plane clouds)
// 2: fancy
// 3: super fancy
#define CLOUD_TYPE 2
// [0, ...]
#define CLOUD_RENDER_DISTANCE 12


// [0.0, 1.0]
// 1.0 means complete reflective and blocks lose their texture!
#define WATER_REFLECTANCE 0.58
// Glass blocks, slime blocks, honey blocks, ice blocks, etc.
#define ALPHA_BLENDED_BLOCKS_REFLECTANCE 0.24


// Delete or comment out to disable.
#define ENABLE_CLOUDS
#define ENABLE_SUN
#define ENABLE_MOON
#define ENABLE_STARS

/* Preset End */





// ---------- Vanilla Colours ----------
const vec3 dayCloudCol = vec3(0.85, 0.89, 1.0);
const vec3 setCloudCol = vec3(0.42, 0.32, 0.32);
const vec3 nightCloudCol = vec3(0.07, 0.07, 0.11);

const vec3 dayCloudShadowCol = vec3(0.67, 0.72, 0.82);
const vec3 setCloudShadowCol = vec3(0.32, 0.26, 0.27);
const vec3 nightCloudShadowCol = vec3(0.05, 0.05, 0.08);

const vec3 daySunInnerCol = vec3(1.0, 1.0, 1.0);
const vec3 setSunInnerCol = vec3(1.0, 1.0, 1.0);
const vec3 nightSunInnerCol = vec3(1.0, 1.0, 0.89);

const vec3 daySunOuterCol = vec3(1.0, 1.0, 1.0);
const vec3 setSunOuterCol = vec3(1.0, 1.0, 0.52);
const vec3 nightSunOuterCol = vec3(1.0, 1.0, 0.5);

const vec3 daySunHaloCol = vec3(0.61, 0.78, 0.93);
const vec3 setSunHaloCol = vec3(0.95, 0.56, 0.15);
const vec3 nightSunHaloCol = vec3(0.3, 0.33, 0.29);

const vec3 dayMoonOuterCol = vec3(0.37, 0.4, 0.48);
const vec3 setMoonOuterCol = vec3(0.37, 0.4, 0.48);
const vec3 nightMoonOuterCol = vec3(0.37, 0.4, 0.48);

const vec3 dayMoonInnerCol = vec3(0.85, 0.89, 1.0);
const vec3 setMoonInnerCol = vec3(0.85, 0.89, 1.0);
const vec3 nightMoonInnerCol = vec3(0.85, 0.89, 1.0);

const vec3 dayMoonDiffuseCol = vec3(0.15, 0.16, 0.27);
const vec3 setMoonDiffuseCol = vec3(0.15, 0.16, 0.27);
const vec3 nightMoonDiffuseCol = vec3(0.15, 0.16, 0.27);

const vec3 daySkyCol = vec3(0.49, 0.65, 1.0);
const vec3 setSkyCol = vec3(0.15, 0.22, 0.41);
const vec3 nightSkyCol = vec3(0.0, 0.0, 0.0);

const vec3 dayFogCol = vec3(0.67, 0.82, 1.0);
const vec3 setFogCol = vec3(0.64, 0.24, 0.02);
const vec3 nightFogCol = vec3(0.02, 0.03, 0.05);
// -------------------------------------





// don't delete it.
#endif /* !PRESET_INCLUDED */