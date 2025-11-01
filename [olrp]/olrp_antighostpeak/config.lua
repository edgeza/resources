-- Simple Anti-Ghost Peak Configuration
-- Prevents firing when ghost peeking

Config = {}

-- Core Settings
Config.Enabled = true
Config.DebugMode = false

-- Detection Settings
Config.WeaponRaycastDistance = 6.0 -- Distance for weapon-based raycast (extremely strict)
Config.CameraRaycastDistance = 1000.0 -- Distance for camera-based raycast
Config.DetectionThreshold = 0.2 -- Minimum distance difference to trigger detection (extremely sensitive)
Config.MaxDistanceToObstacle = 1.0 -- Maximum distance player must be from obstacle (touching wall)
Config.RaycastFlags = 1 -- Raycast collision flags
Config.HeightOffset = 0.0 -- Height offset for raycast origin
Config.CrouchDetection = true -- Extra strict detection when crouching

-- Performance Settings
Config.UpdateInterval = 0 -- Check every frame when aiming
Config.IdleUpdateInterval = 1000 -- Check every second when not aiming

-- Weapon Settings
Config.RequireWeapon = true -- Only work when player has weapon

-- Exemption Settings
Config.AdminExempt = true -- Admins are exempt from detection
Config.ExemptGroups = {} -- Add group names to exempt list
Config.ExemptPlayers = {} -- Add player IDs to exempt list
