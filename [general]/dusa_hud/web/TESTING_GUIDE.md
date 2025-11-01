# Dusa HUD Draggable Testing Guide

## Quick Diagnostic Steps

### Step 1: Check if Individual Status Bars Are Enabled

In-game, run `/hudmenu` and check these settings:

**Status Settings:**
- [ ] "Hide All Status" should be **OFF/UNCHECKED**
- [ ] Individual status bars (Health, Hunger, Thirst, Armor, Energy, Stress, Oxygen) should be **OFF/UNCHECKED** (meaning they're visible)

**General Settings:**
- [ ] "Freeform Edit Mode" - Toggle this **ON**

### Step 2: What You Should See

When Freeform Edit Mode is ON, you should see **colored dashed outlines** around status bars:
- 🔴 Red outline = Health
- 🟠 Orange outline = Hunger
- 🔵 Blue outline = Thirst
- 🔷 Cyan outline = Armor
- 🟢 Green outline = Energy
- 🟣 Purple outline = Stress
- 🌊 Teal outline = Oxygen
- 🟡 Yellow outline = CAPS

### Step 3: Where to Look

The status bars should appear around:
- **X position**: 16px - 400px from the left edge
- **Y position**: ~500px from the top (middle of screen)
- Check the **left side** of your screen, roughly in the middle vertically

### Step 4: Test Dragging

1. **Click and hold** on a colored outline
2. **Move your mouse** - the element should move with it
3. **Release** - position saves

## Troubleshooting

### Issue: "I don't see any colored outlines"

**Possible causes:**
1. **All Status is ON** - Check Status Settings, turn OFF "Hide All Status"
2. **Individual bars are hidden** - In Status Settings, make sure Health, Hunger, etc. checkboxes are OFF (unchecked)
3. **Status bars are off-screen** - They might be rendering outside visible area

### Issue: "I see the outlines but can't drag"

**Possible causes:**
1. **Freeform Mode is OFF** - Double-check it's enabled in General Settings
2. **NUI mouse is not active** - You might need cursor enabled (check if other draggables like Menu/Speedo work)

### Issue: "The regular status bar (group) is still showing"

This means we need to disable the old grouped rendering. We should ONLY see individual status bars when in freeform mode.

---

## For Developer/Advanced Users

If you can access the browser console (`nui_devtools 1` in F8):

**Look for these logs:**
```
[Dusa HUD] Freeform Edit Mode: true
[Dusa HUD] Current positions: {health: {x: 16, y: 500}, ...}
[Dusa HUD] Position updated for health: {x: 50, y: 520}
```

**Check these values in console:**
```javascript
// In browser DevTools console, type:
window.__REACT_DEVTOOLS_GLOBAL_HOOK__

// Or check if settings object is accessible
```

---

## Next Steps

Please answer these questions so I can fix the exact issue:

1. **Do you see ANY colored outlines when you enable Freeform Mode?**
   - [ ] Yes, I see colored outlines
   - [ ] No, I don't see any outlines

2. **Do you still see the normal status bar group (all statuses together)?**
   - [ ] Yes, the normal grouped status bar is still there
   - [ ] No, I don't see any status bars at all

3. **Can you drag other elements (Server Info, Menu panel, Speedometer)?**
   - [ ] Yes, I can drag the Server Info/Menu/Speedo
   - [ ] No, I can't drag anything

Your answers will help me pinpoint the exact issue!

