# Wild Beehive Minigame Integration

## ✅ What Was Implemented

The wild beehive system now includes an interactive **minigame** that players must complete to collect bees from wild hives. 

### Features:
- **Target/ThirdEye Integration**: Players use ThirdEye on wild hives to interact
- **Required Items**: Players MUST have both **Torch Smoker** AND **Bug Net** to start
- **Precision Minigame**: Players complete a timing-based minigame (3 rounds, medium difficulty)
- **Success**: 
  - Hive disappears and respawns at a different random location (out of 100 possible spots)
  - Player receives rewards (bees, queens, honey)
- **Failure**:
  - Player gets stung (health loss, camera shake, ragdoll effect)
  - Hive stays in place with a 30-second cooldown
  - No rewards given

## 📦 Installation Steps

### 1. Add to server.cfg
Make sure these resources are started IN THIS ORDER:
```cfg
ensure qb-core
ensure qb-target
ensure ox_lib
ensure jl_minigame
ensure olrp_beekeeping
```

### 2. Resource Files
The following files were created/modified:

**New Resource:**
- `resources/[Stitch_Scripts]/jl_minigame/` - The minigame system

**Modified Files:**
- `olrp_beekeeping/client/menu_events.lua` - Added minigame interaction logic
- `olrp_beekeeping/server/server.lua` - Added callbacks and reward handling
- `olrp_beekeeping/fxmanifest.lua` - Added jl_minigame dependency
- `olrp_beekeeping/config.lua` - Z-coordinates adjusted for all 100 hives

### 3. Database Items
Ensure these items exist in your `qb-core/shared/items.lua`:
```lua
['torch_smoker'] = {['name'] = 'torch_smoker', ['label'] = 'Torch Smoker', ['weight'] = 500, ['type'] = 'item', ['image'] = 'torch_smoker.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A smoker to calm bees'},
['bug_net'] = {['name'] = 'bug_net', ['label'] = 'Bug Net', ['weight'] = 300, ['type'] = 'item', ['image'] = 'bug_net.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A net for catching bees'},
['basic_bees'] = {['name'] = 'basic_bees', ['label'] = 'Worker Bees', ['weight'] = 100, ['type'] = 'item', ['image'] = 'basic_bees.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A jar of worker bees'},
['basic_queen'] = {['name'] = 'basic_queen', ['label'] = 'Queen Bee', ['weight'] = 100, ['type'] = 'item', ['image'] = 'basic_queen.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A queen bee in a jar'},
['honey'] = {['name'] = 'honey', ['label'] = 'Honey', ['weight'] = 200, ['type'] = 'item', ['image'] = 'honey.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Sweet golden honey'},
```

## 🎮 How to Use

### For Players:
1. **Acquire Required Items**:
   - Torch Smoker (`torch_smoker`)
   - Bug Net (`bug_net`)

2. **Find a Wild Beehive**:
   - Wild hives spawn at 50 random locations from a pool of 100
   - They appear as bushes (`prop_bush_lrg_01`)

3. **Interact with the Hive**:
   - Use ThirdEye (or qb-target) on the bush
   - Select "Catch Bees"
   - Watch the progress bar as you calm the hive

4. **Complete the Minigame**:
   - Press **E** when the white marker is in the green zone
   - You need 3 successful hits within 15 seconds
   - Timing is everything!

5. **Results**:
   - **Success**: Get bees/queens/honey, hive moves to new location
   - **Failure**: Get stung, try again in 30 seconds

### For Admins:
```
/spawnallwildhives - Spawn all 100 wild hive locations (testing only)
/clearwildhives - Remove all active wild hives
/taptest medium 3 - Test the minigame directly
```

## ⚙️ Configuration

You can adjust the minigame difficulty in `jl_minigame/config.lua`:
```lua
Config.Defaults = {
  difficulty = 'medium',   -- 'easy' | 'medium' | 'hard' | 'extreme'
  rounds = 2,              -- how many successful hits required
  timeLimit = 15.0,        -- total seconds allowed
}
```

Current wild hive interaction settings (in `menu_events.lua` line ~454):
```lua
local success = exports['jl_minigame']:Play({
    difficulty = 'medium',
    rounds = 3,
    timeLimit = 15.0
})
```

## 🐝 Reward System

When players successfully complete the minigame, they receive:
- **60% chance**: Worker Bees (1-3)
- **30% chance**: Queen Bee (1)
- **10% chance**: Both Worker Bees + Queen
- **Always**: Honey (2 units)

Rewards are defined per wild hive location in `config.lua` (Config.WildBeehives array).

## 🔧 Troubleshooting

### Hives not appearing?
- Make sure wild hive spawning is enabled in config
- Check that the resource started without errors
- Try `/spawnallwildhives` as admin to test

### Can't interact with hives?
- Verify qb-target is working
- Check you have both smoker AND bugnet in inventory
- Look for error messages in F8 console

### Minigame not starting?
- Ensure jl_minigame resource is started BEFORE olrp_beekeeping
- Check that the export is working: `exports['jl_minigame']:Play(...)`
- Test with `/taptest medium 3` command

## 📝 Notes

- The old menu-based interaction system is still in the code (marked as "OLD MENU SYSTEM") but is no longer used
- Wild hives will automatically respawn at different locations after successful collection
- Maximum 50 active wild hives at once (configurable in Config.WildBeehiveMaxActive)
- Hives rotate to new locations every 30 minutes (configurable in Config.WildBeehiveRotationTime)

## 🎉 Enjoy Your New Beekeeping Experience!

Happy buzzing! 🐝

