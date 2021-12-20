#ifndef PRESET_INCLUDED
#define PRESET_INCLUDED
// ^ don't delete them.





/* Preset file of Reflective Vanilla Shaders */

// 1: fast (plane clouds)
// 2: fancy
// 3: super fancy
#define CLOUD_TYPE 3
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
static const float3 dayCloudCol = float3(0.85, 0.89, 1.0);
static const float3 setCloudCol = float3(0.42, 0.32, 0.32);
static const float3 nightCloudCol = float3(0.07, 0.07, 0.11);

static const float3 dayCloudShadowCol = float3(0.67, 0.72, 0.82);
static const float3 setCloudShadowCol = float3(0.32, 0.26, 0.27);
static const float3 nightCloudShadowCol = float3(0.05, 0.05, 0.08);

static const float3 daySunInnerCol = float3(1.0, 1.0, 1.0);
static const float3 setSunInnerCol = float3(1.0, 1.0, 1.0);
static const float3 nightSunInnerCol = float3(1.0, 1.0, 0.89);

static const float3 daySunOuterCol = float3(1.0, 1.0, 1.0);
static const float3 setSunOuterCol = float3(1.0, 1.0, 0.52);
static const float3 nightSunOuterCol = float3(1.0, 1.0, 0.5);

static const float3 daySunHaloCol = float3(0.61, 0.78, 0.93);
static const float3 setSunHaloCol = float3(0.95, 0.56, 0.15);
static const float3 nightSunHaloCol = float3(0.3, 0.33, 0.29);

static const float3 dayMoonOuterCol = float3(0.37, 0.4, 0.48);
static const float3 setMoonOuterCol = float3(0.37, 0.4, 0.48);
static const float3 nightMoonOuterCol = float3(0.37, 0.4, 0.48);

static const float3 dayMoonInnerCol = float3(0.85, 0.89, 1.0);
static const float3 setMoonInnerCol = float3(0.85, 0.89, 1.0);
static const float3 nightMoonInnerCol = float3(0.85, 0.89, 1.0);

static const float3 dayMoonDiffuseCol = float3(0.15, 0.16, 0.27);
static const float3 setMoonDiffuseCol = float3(0.15, 0.16, 0.27);
static const float3 nightMoonDiffuseCol = float3(0.15, 0.16, 0.27);

static const float3 daySkyCol = float3(0.49, 0.65, 1.0);
static const float3 setSkyCol = float3(0.15, 0.22, 0.41);
static const float3 nightSkyCol = float3(0.0, 0.0, 0.0);

static const float3 dayFogCol = float3(0.67, 0.82, 1.0);
static const float3 setFogCol = float3(0.64, 0.24, 0.02);
static const float3 nightFogCol = float3(0.02, 0.03, 0.05);
// -------------------------------------





// don't delete it.
#endif /* !PRESET_INCLUDED */