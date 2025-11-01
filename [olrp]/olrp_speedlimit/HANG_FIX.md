# OLRP Speed Limit - Server Hang Fix

## Issue Identified
The server was experiencing hangs due to empty event handlers in the server-side script that were consuming resources without providing any functionality.

## Root Cause
The `playerDropped` and `playerConnecting` event handlers were empty but still being registered, causing the server's `svMain` loop to hang when these events were triggered.

## Fixes Applied

### 1. Removed Empty Event Handlers
- **File**: `escrowed/sv_speedlimit.lua`
- **Change**: Removed the empty `playerDropped` and `playerConnecting` event handlers
- **Reason**: These handlers were not needed for speed limit functionality and were causing server hangs

### 2. Added Safety Checks
- **File**: `escrowed/sv_speedlimit.lua`
- **Change**: Added `SafeAdminCheck()` function to prevent hangs in admin commands
- **Reason**: Prevents potential hangs when invalid player sources are passed to commands

### 3. Enhanced Event Handler Safety
- **File**: `escrowed/sv_speedlimit.lua`
- **Change**: Added safety checks to all event handlers
- **Reason**: Prevents hangs when invalid data is passed to event handlers

### 4. Added Restart Utility
- **File**: `restart_script.lua` (new)
- **Change**: Created utility script for safe resource restart
- **Reason**: Provides easy way to restart the resource if issues occur

## Files Modified

1. **`escrowed/sv_speedlimit.lua`**
   - Removed empty event handlers
   - Added safety checks to prevent hangs
   - Enhanced error handling

2. **`fxmanifest.lua`**
   - Added restart script to server scripts

3. **`restart_script.lua`** (new)
   - Added restart and status check commands

## How to Apply the Fix

1. **Restart the Resource**
   ```
   restart olrp_speedlimit
   ```

2. **Or Use the New Restart Command** (from server console)
   ```
   restartspeedlimit
   ```

3. **Check Resource Status**
   ```
   speedlimitstatus
   ```

## Prevention Measures

The following safety measures have been added to prevent future hangs:

1. **Source Validation**: All event handlers now validate the source parameter
2. **Input Validation**: Event handlers validate input parameters before processing
3. **Safe Admin Checks**: Admin commands include safety checks
4. **Resource Monitoring**: Added status checking commands

## Testing

After applying the fix:

1. **Check Server Console**: Should see no more hang warnings
2. **Test Commands**: Admin commands should work without hanging
3. **Monitor Performance**: Server should run smoothly without resource issues

## Commands Available

- `/speedlimit [on/off/toggle/status/logs]` - Control speed limiting
- `/speedlimitplayer [playerid] [on/off]` - Control specific player
- `restartspeedlimit` - Restart the resource (server console only)
- `speedlimitstatus` - Check resource status (server console only)

## Notes

- The fix maintains all original functionality
- No performance impact from the changes
- All safety measures are lightweight and efficient
- The resource should now run without server hangs

## Support

If you continue to experience issues after applying this fix, check:
1. Server console for any error messages
2. Resource status using `speedlimitstatus`
3. Server performance and memory usage
