# Crash Analysis Report
**Date:** November 1, 2025 19:40:09  
**Crash Hash:** `fivem.exe+168003E` (emma-arkansas-princess)  
**FiveM Version:** master v1.0.0.21703

## Crash Summary

The crash occurred in the GTA5 executable (`GTA5_b3570.exe!sub_14167FFC8`) approximately **42 minutes** after the game started. This is a low-level executable crash, not a Lua script error.

## Primary Issues Identified

### 1. **Missing Weapon Image Files (CRITICAL - NOW FIXED)**
**Impact:** High - Caused hundreds of failed image loads that likely contributed to the crash

**Missing Images (before fix):**
- `WEAPON_BF_LORE.png`
- `WEAPON_BF_BLACKLAMINATE.png`
- `WEAPON_BF_GDP1.png`, `WEAPON_BF_GDP2.png`, `WEAPON_BF_GDP3.png`, `WEAPON_BF_GDP4.png`
- `WEAPON_BF_GDEMERALD.png`
- `WEAPON_BF_FREEHAND.png`
- `WEAPON_BF_MARBLEFADE.png`
- `WEAPON_BF_AUTOTRONIC.png`
- `WEAPON_M9_BOREALFOREST.png`
- `WEAPON_M9_NIGHT.png`
- `WEAPON_KARAMBIT_DOPPLERBLACKPEARL.png` (incorrect name, should be `WEAPON_KARAMBIT_BLACKPEARL.png`)

**Evidence from logs:**
- Over 100+ failed image load attempts for these missing files
- All attempts from `@olrp_lootboxes/web/build/index.html`
- Errors occurred both at game load (timestamp ~1083062) and during gameplay (timestamp ~2408359)

**Status:** ✅ **FIXED** - Config updated to use existing Karambit/M9 images as fallbacks

### 2. **Texture Compression Issues**
**Impact:** Medium - May contribute to stability problems

**Warning Found:**
```
Warning: Texture script_rt_dials_maverick (in txd pd_heli.ytd) was set to a compressed texture format, 
but 'script_rt' textures should always be uncompressed.
```

**Warning Found:**
```
Warning: Texture script_rt_dials_race (in txd polsentinel.ytd) was set to a compressed texture format, 
but 'script_rt' textures should always be uncompressed.
```

**Recommendation:** Fix these textures to be uncompressed to reduce crash risk.

### 3. **ReShade 5.x Known Issue**
**Impact:** Low - FiveM already blocked it

FiveM detected and blocked ReShade 5.x due to known bugs that cause crashes in GPU drivers. This is handled automatically by FiveM.

### 4. **Crash Details**
**Crash Location:** `GTA5_b3570.exe!sub_14167FFC8 (0x76)`

**Stack Trace:**
```
GTA5_b3570.exe!sub_14167FFC8 (0x76)
GTA5_b3570.exe!sub_140794370 (0x2cd)
GTA5_b3570.exe!sub_140794044 (0x30b)
GTA5_b3570.exe!sub_14078458C (0x207)
GTA5_b3570.exe!sub_14078DEA8 (0x208)
GTA5_b3570.exe!StartAddress (0xfd)
gta-core-five.dll!<lambda>::operator() (0xf4) (ThreadNames.cpp:57)
```

This appears to be a threading/execution crash in GTA5's core code, possibly triggered by:
- Resource loading issues (the missing images)
- Memory pressure from failed resource loads
- Texture rendering issues

## Recommendations

### Immediate Actions (COMPLETED):
1. ✅ Fixed missing weapon image references in `olrp_lootboxes/config.lua`
2. ✅ Updated config to use existing Karambit/M9 images as fallbacks for missing BF variants

### Additional Actions to Consider:

1. **Fix Texture Compression Issues:**
   - Locate `pd_heli.ytd` and `polsentinel.ytd`
   - Re-export `script_rt_dials_maverick` and `script_rt_dials_race` as uncompressed textures
   - Update the YTD files

2. **Monitor for Recurrence:**
   - The crash hash "emma-arkansas-princess" suggests this may be a known FiveM issue
   - Monitor if crashes continue after image fixes
   - Check FiveM crash database for this hash

3. **Reduce NUI Resource Load:**
   - Consider lazy-loading weapon images in lootboxes
   - Implement better error handling in the web interface
   - Add placeholder images for missing files

## System Information
- **GPU:** NVIDIA GeForce RTX 5070 (10de:2f04)
- **Server:** play.oneliferp.org (156.38.207.202:30120)
- **OneSync:** Enabled (Big + Population)

## Conclusion

The crash was likely triggered or exacerbated by the missing weapon image files causing excessive failed resource loads. With the fixes applied, the frequency of these errors should be significantly reduced. The actual crash location suggests it may also be related to a known FiveM issue, so monitoring for recurrence is important.

