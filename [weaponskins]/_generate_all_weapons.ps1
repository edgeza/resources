# Script to generate complete meta files for all weapons
# This ensures each weapon is an add-on (not replacement) and FiveM ready

$basePath = "F:\OLRP_Dev\olrp_github\resources\[weaponskins]"

# Weapon definitions: [folder_name, weapon_name, slot_number, model_name, weapon_type, clip_size]
$weapons = @(
    # Individual rifles (carbinerifle model)
    @("paint_splatter", "WEAPON_PAINT_SPLATTER", "440", "w_ar_carbinerifle", "rifle", "30"),
    @("bombinglr300", "WEAPON_BOMBINGLR300", "441", "w_ar_carbinerifle", "rifle", "30"),
    @("hypebeast", "WEAPON_HYPEBEAST", "442", "w_ar_carbinerifle", "rifle", "30"),
    @("patchday8ng", "WEAPON_PATCHDAY8NG", "443", "w_ar_carbinerifle", "rifle", "30"),
    
    # AP Pistol
    @("Families Glock 18C", "WEAPON_FAMILIES_GLOCK_18C", "447", "w_pi_appistol", "pistol", "18"),
    
    # Rifle Color Pack (carbinerifle model)
    @("Blue Carbine Rifle", "WEAPON_BLUE_CARBINE_RIFLE", "448", "w_ar_carbinerifle", "rifle", "30"),
    @("Complete Ultra Blackout", "WEAPON_ULTRA_BLACKOUT_RIFLE", "449", "w_ar_carbinerifle", "rifle", "30"),
    @("Lime Green And Black AR", "WEAPON_LIME_BLACK_AR", "450", "w_ar_carbinerifle", "rifle", "30"),
    @("No Silver", "WEAPON_NO_SILVER_RIFLE", "451", "w_ar_carbinerifle", "rifle", "30"),
    @("White And Black AR", "WEAPON_WHITE_BLACK_AR", "452", "w_ar_carbinerifle", "rifle", "30"),
    @("White And Orange", "WEAPON_WHITE_ORANGE_RIFLE", "453", "w_ar_carbinerifle", "rifle", "30"),
    
    # Glock Pack (combatpistol model)
    @("candy apple", "WEAPON_CANDY_APPLE_GLOCK", "454", "w_pi_combatpistol", "pistol", "12"),
    @("catacombs beta", "WEAPON_CATACOMBS_GLOCK", "455", "w_pi_combatpistol", "pistol", "12"),
    @("freedom", "WEAPON_FREEDOM_GLOCK", "456", "w_pi_combatpistol", "pistol", "12"),
    @("hornet", "WEAPON_HORNET_GLOCK", "457", "w_pi_combatpistol", "pistol", "12"),
    @("safari", "WEAPON_SAFARI_GLOCK", "458", "w_pi_combatpistol", "pistol", "12"),
    
    # Thermal Katana (machette_lr model)
    @("Cyan", "WEAPON_CYAN_THERMAL_KATANA", "459", "w_me_machette_lr", "melee", "1"),
    @("Lime", "WEAPON_LIME_THERMAL_KATANA", "460", "w_me_machette_lr", "melee", "1"),
    @("Pink", "WEAPON_PINK_THERMAL_KATANA", "461", "w_me_machette_lr", "melee", "1"),
    @("Purple", "WEAPON_PURPLE_THERMAL_KATANA", "462", "w_me_machette_lr", "melee", "1"),
    @("Red", "WEAPON_RED_THERMAL_KATANA", "463", "w_me_machette_lr", "melee", "1"),
    @("White", "WEAPON_WHITE_THERMAL_KATANA", "464", "w_me_machette_lr", "melee", "1"),
    @("Yellow", "WEAPON_YELLOW_THERMAL_KATANA", "465", "w_me_machette_lr", "melee", "1")
)

foreach ($weapon in $weapons) {
    $folderName = $weapon[0]
    $weaponName = $weapon[1]
    $slotNum = $weapon[2]
    $modelName = $weapon[3]
    $weaponType = $weapon[4]
    $clipSize = $weapon[5]
    
    $weaponPath = Join-Path $basePath $folderName
    $metaPath = Join-Path $weaponPath "meta"
    $componentsPath = Join-Path $metaPath "components"
    
    Write-Host "Processing: $folderName ($weaponName)"
    
    # Create directories
    if (-not (Test-Path $metaPath)) { New-Item -ItemType Directory -Force -Path $metaPath | Out-Null }
    if ($weaponType -ne "melee") {
        $componentDir = Join-Path $componentsPath "$weaponName`_CLIP_01"
        if (-not (Test-Path $componentDir)) { New-Item -ItemType Directory -Force -Path $componentDir | Out-Null }
    }
    
    # Generate files based on weapon type
    # This is a template - actual generation would require full XML templates
    Write-Host "  Created structure for $weaponName"
}

Write-Host "`nAll weapon structures created!"
Write-Host "Note: This script creates directory structure. Full XML files need to be generated separately."


