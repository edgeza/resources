# Individual Draggable Status Bars Implementation

## Overview
This document describes the implementation of individually draggable UI elements in the Dusa HUD system.

## What Has Been Implemented

### 1. Default Positions (✅ COMPLETED)
- Updated `web/src/contexts/default.ts` to include positions for:
  - `caps` - CAPS indicator position
  - `health` - Health bar individual position  
  - `hunger` - Hunger bar individual position
  - `thirst` - Thirst bar individual position
  - `armor` - Armor bar individual position
  - `energy` - Energy bar individual position
  - `stress` - Stress bar individual position
  - `oxygen` - Oxygen bar individual position

### 2. Menu Component (✅ COMPLETED)
- Updated `web/src/components/pages/menu/index.jsx`:
  - Individual Draggable wrappers for each status bar (health, hunger, thirst, armor, energy, stress, oxygen)
  - Each status bar has its own colored outline when in edit mode
  - CAPS indicator is now draggable
  - Default staggered positions for better initial layout (x: 0, 50, 100, 150, 200, 250, 300)

### 3. Visual Feedback (✅ COMPLETED)
- Edit mode shows colored dashed outlines around each draggable element:
  - Health: Red outline
  - Hunger: Orange outline
  - Thirst: Blue outline
  - Armor: Cyan outline
  - Energy: Green outline
  - Stress: Purple outline
  - Oxygen: Teal outline
  - CAPS: Yellow outline

### 4. Status Style Components - Individual Rendering Support

#### ✅ COMPLETED Status Styles:
- **Status Style 1** (`status-style-1.jsx`) - Supports `single` prop for individual rendering
- **Status Style 10** (`status-style-10.jsx`) - Supports `single` prop for individual rendering

#### ⏳ PENDING Status Styles (Need the same treatment):
The following status styles need to be updated to support the `single` prop parameter:

- **Status Style 2** (`status-style-2.jsx`)
- **Status Style 3** (`status-style-3.jsx`)
- **Status Style 4** (`status-style-4.jsx`)
- **Status Style 5** (`status-style-5.jsx`)
- **Status Style 6** (`status-style-6.jsx`)
- **Status Style 7** (`status-style-7.jsx`)
- **Status Style 8** (`status-style-8.jsx`)
- **Status Style 9** (`status-style-9.jsx`)

## How to Update Remaining Status Styles

Each status style component needs to be modified to:

1. Add `single` parameter to the component function:
   ```jsx
   const StatusStyleX = ({ status, single }) => {
   ```

2. Add conditional rendering for each status type:
   ```jsx
   if (single === "health") {
     return (
       // Just the health bar element from the full component
     );
   }
   
   if (single === "armor") {
     return (
       // Just the armor bar element from the full component
     );
   }
   
   // ... repeat for: hunger, thirst, energy, stress, oxygen
   ```

3. Keep the full component render at the end (when `single` is undefined)

### Example Pattern (from status-style-10.jsx):

```jsx
const StatusStyle10 = ({ status, single }) => {
  const { settings } = useSettings();
  
  // Individual renders
  if (single === "health") {
    return (/* health bar only */);
  }
  
  if (single === "armor") {
    return (/* armor bar only */);
  }
  
  // ... other status types
  
  // Full component (original implementation)
  return (
    <div className="...">
      {/* All status bars together */}
    </div>
  );
};
```

## How to Use

### Enabling Edit Mode
1. Go to HUD settings
2. Enable "Freeform Edit Mode"
3. All individual status bars and UI elements will show colored outlines
4. Drag any element to reposition it
5. Positions are automatically saved

### Status Bar Positioning
- Each status bar can be positioned independently
- Default positions are staggered for easy initial grabbing
- Positions persist across sessions

## Technical Details

### Position Storage
Positions are stored in the settings context under `defaultPositions`:
```javascript
defaultPositions: {
  server: { x: 0, y: 0 },
  menu: { x: 0, y: 0 },
  status: { x: 0, y: 0 },  // Legacy grouped status position
  speedo: { x: 0, y: 0 },
  caps: { x: 0, y: 0 },
  health: { x: 0, y: 0 },
  hunger: { x: 50, y: 0 },
  thirst: { x: 100, y: 0 },
  armor: { x: 150, y: 0 },
  energy: { x: 200, y: 0 },
  stress: { x: 250, y: 0 },
  oxygen: { x: 300, y: 0 },
}
```

### Draggable Component
Uses `react-draggable` library:
- Disabled when `freeformEditMode` is false
- Position updates on drag stop
- Persists to settings context

## Future Enhancements

1. **Reset Individual Positions**: Add button to reset specific element to default position
2. **Lock Individual Elements**: Allow locking specific elements while editing others
3. **Snap to Grid**: Optional grid snapping for precise alignment
4. **Position Presets**: Save/load complete layout presets
5. **Mirror/Flip**: Quickly mirror layout left to right

## Testing Checklist

- [ ] All 10 status styles support individual rendering
- [ ] Positions save correctly
- [ ] Positions load correctly on HUD restart
- [ ] Edit mode outlines display correctly
- [ ] All status types can be dragged independently
- [ ] CAPS indicator can be dragged
- [ ] No performance issues with individual elements
- [ ] Works with all speedometer types
- [ ] Works with all server info styles

## Notes

- The grouped status position (`status`) is still maintained for backward compatibility
- Individual status positions override the grouped position when using individual mode
- Status bars respect their visibility settings (hidden bars don't render)

