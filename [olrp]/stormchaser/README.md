# Stormchaser Resource

Dynamic storm chasing gameplay loop for Qbox/QBCore servers. Storm cells spawn randomly across San Andreas, broadcast their position on a dedicated tablet, and reward storm-chasing crews who successfully deploy probes and sell the captured telemetry to the news station.

## Features

- Randomly timed severe storm cells that traverse the entire map with drift and lifetime controls.
- Heatmap-style tablet UI (NUI) that visualizes the current storm footprint, heading, and probe locations.
- Equipment loop with reusable `storm_probe` deployables and `storm_tablet` access item.
- Reward pipeline that converts collected probe data into sellable intel at the Weazel News desk.
- Automatic client sync for storms, probes, and keybind support (`F1` by default).

## Installation

1. Place the `stormchaser` folder inside your server's resources directory (e.g. `resources/[local]/stormchaser`).
2. Add the resource to your `server.cfg`:
   ```
   ensure stormchaser
   ```
3. Add the following items to `qb-core/shared/items.lua` (or Qbox equivalent). Adjust images/weights as desired:
   ```lua
   ['storm_tablet'] = {
       ['name'] = 'storm_tablet',
       ['label'] = 'Storm Tablet',
       ['weight'] = 1000,
       ['type'] = 'item',
       ['image'] = 'storm_tablet.png',
       ['unique'] = true,
       ['useable'] = true,
       ['shouldClose'] = true,
       ['combinable'] = nil,
       ['description'] = 'Portable doppler display for storm chasing crews.'
   },
   ['storm_probe'] = {
       ['name'] = 'storm_probe',
       ['label'] = 'Storm Probe',
       ['weight'] = 4500,
       ['type'] = 'item',
       ['image'] = 'storm_probe.png',
       ['unique'] = false,
       ['useable'] = true,
       ['shouldClose'] = true,
       ['combinable'] = nil,
       ['description'] = 'Deployable probe that captures storm data.'
   },
   ['storm_data'] = {
       ['name'] = 'storm_data',
       ['label'] = 'Storm Data Drive',
       ['weight'] = 150,
       ['type'] = 'item',
       ['image'] = 'usb_device.png',
       ['unique'] = false,
       ['useable'] = false,
       ['shouldClose'] = true,
       ['combinable'] = nil,
       ['description'] = 'Collected atmospheric telemetry ready for sale.'
   },
   ```
4. (Optional) Provide inventory icons for the items and place them in your inventory UI.

## Configuration

All tunables live in `config.lua`. Highlights:

- `StormSpawnIntervalMinutes`, `StormLifetimeMinutes`, `StormSpeed`, `RandomDrift`: control pacing and behaviour.
- `StormRadius` and `DataCaptureRadius`: adjust the detection footprints.
- `BasePayout` and `QualityMultiplier`: scale rewards per probe quality tier.
- `NewsStation`: location & blip for selling data. If `qb-target` is running, an interaction zone is added automatically.
- `Tablet.openKey`: change or disable the default keybind for opening the tablet UI.

## Gameplay Loop

1. Obtain a `storm_tablet` and `storm_probe` (via job shop, stash, admin give, etc.).
2. Open the tablet (`F1` or item use) to track the active storm and plan probe placement.
3. Use the probe item to deploy equipment in the projected storm path (max 3 per player).
4. When the storm passes close enough, retrieve the probe to receive a `storm_data` drive.
5. Sell the drive at the Weazel News desk for cash. Higher-quality captures pay more.

## Testing Checklist

- Use `/giveitem` (admin) to grant yourself the tablet and probes.
- Wait for an automated storm spawn, or temporarily reduce `StormSpawnIntervalMinutes` for quicker testing.
- Confirm the tablet shows heatmap + heading, and that probes appear on both the tablet and in-world.
- Ensure probes respect the per-player limit and return the item when collected.
- Verify `storm_data` drives pay out when sold at the news station (`qb-target` interaction or `/stormtablet` menu if target is missing).
- Test reconnecting mid-storm to ensure the tablet resyncs storm and probe states.

## Notes

- If `qb-target` is not available, players can still sell data by opening the tablet item and selecting the sell button (keybind command). Consider adding a command or alternate interaction if desired.
- The NUI uses the default `F1` key. Players without the tablet item cannot open it.
- Set `Config.Debug = true` for additional console logging and target zone debugging.

