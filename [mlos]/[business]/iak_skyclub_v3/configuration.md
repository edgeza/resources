---
description: Welcome to the Skyclub v3 Configuration Guide!
---

# Configuration

```
MBT.MenuCoords = vector3(-905.28, -448.8, 160.31)
MBT.Distance = 10.0
```

**Coords**: This variable defines the coordinates where the menu is located. It uses the `vector3` data type to represent a 3D point in space (X, Y, Z coordinates).

**Distance**: This variable specifies the distance from which the menu can be interacted with.

***

```
MBT.Blip = {
    ["Active"] = true,
    ["Location"] = vector3(-911.64, -451.13, 39.61),
    ["Name"] = "Skyclub",
    ["Sprite"] = 675,
    ["Colour"] = 61,
    ["Scale"] = 1.0
}
```

This is a table that contains settings related to a map blip.

* `Active`: Indicates whether the blip should be displayed on the map.
* `Location`: The coordinates where the blip will be shown on the map.
* `Name`: The display name of the blip.
* `Sprite`: The numeric ID of the sprite/icon to use for the blip.
* `Colour`: The color of the blip on the map.
* `Scale`: The scale of the blip icon.

***

```
MBT.Labels = {
    ["open_menu"] = "~INPUT_PICKUP~ Open Menu",
    ["dancefloor"] = "Set 1",
    ["open_menu_target"] = "Open Menu"
}
```

This table holds labels for various menu options.

* **open\_menu**: The label for opening the main menu. It includes a control input, likely indicating a button to press.
* **dancefloor**: A label for a specific menu option (possibly related to a dancefloor setting).
* **open\_menu\_target**: A label for opening the menu from a target interaction.

***

```
MBT.TXAdmin = false
MBT.SaveSetsOnPlayerLogout = false
MBT.SaveSetsOnSetChange = true
```

**TXAdmin**: Indicates whether TXAdmin (a server management tool) is active.

**SaveSetsOnPlayerLogout** : Specifies whether sets should be saved when a player logs out.

**SaveSetsOnSetChange** : Specifies whether sets should be saved when there is a change.

***

```
MBT.Target = {
    ["Active"] = true,
    ["Skyclub Menu"] = function ()
        -- Target interaction configuration here
    end
}
```

This table holds settings for a target interaction.

* **Active**: Indicates whether the target interaction is active.
* **Skyclub Menu**: The name of the target interaction. Inside this, there's a function that sets up a target zone with specific properties for interaction.

***