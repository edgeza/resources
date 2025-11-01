// Clean, readable weapon configuration for QS Deathmatch
// This configuration only includes weapons that have corresponding images

const guns = [
    // All weapons option
    { name: "All", img: "all.png", weapon: "all", type: "all" },
    
    // Pistols
    { name: "AP Pistol", img: "appistol.png", weapon: "appistol", type: "pistol" },
    { name: "Pistol", img: "pistol.png", weapon: "pistol", type: "pistol" },
    { name: "Pistol MK II", img: "pistol_mk2.png", weapon: "pistol_mk2", type: "pistol" },
    { name: "Combat Pistol", img: "combatpistol.png", weapon: "combatpistol", type: "pistol" },
    { name: "SNS Pistol", img: "snspistol.png", weapon: "snspistol", type: "pistol" },
    { name: "SNS Pistol MK II", img: "snspistol_mk2.png", weapon: "snspistol_mk2", type: "pistol" },
    { name: "Vintage Pistol", img: "vintagepistol.png", weapon: "vintagepistol", type: "pistol" },
    { name: "Heavy Pistol", img: "heavypistol.png", weapon: "heavypistol", type: "pistol" },
    { name: "Machine Pistol", img: "machinepistol.png", weapon: "machinepistol", type: "pistol" },
    { name: "Marksman Pistol", img: "marksmanpistol.png", weapon: "marksmanpistol", type: "pistol" },
    { name: "Revolver", img: "revolver.png", weapon: "revolver", type: "pistol" },
    { name: "Revolver MK II", img: "revolver_mk2.png", weapon: "revolver_mk2", type: "pistol" },

    // SMGs
    { name: "SMG MK II", img: "smg_mk2.png", weapon: "smg_mk2", type: "smg" },
    { name: "Assault SMG", img: "assaultsmg.png", weapon: "assaultsmg", type: "smg" },
    { name: "Micro SMG", img: "microsmg.png", weapon: "microsmg", type: "smg" },
    { name: "Mini SMG", img: "minismg.png", weapon: "minismg", type: "smg" },

    // Assault Rifles
    { name: "Assault Rifle", img: "assaultrifle.png", weapon: "assaultrifle", type: "rifle" },
    { name: "Assault Rifle MK II", img: "assaultrifle_mk2.png", weapon: "assaultrifle_mk2", type: "rifle" },
    { name: "Carbine Rifle MK II", img: "carbinerifle_mk2.png", weapon: "carbinerifle_mk2", type: "rifle" },
    { name: "Advanced Rifle", img: "advancedrifle.png", weapon: "advancedrifle", type: "rifle" },
    { name: "Special Carbine MK II", img: "specialcarbine_mk2.png", weapon: "specialcarbine_mk2", type: "rifle" },
    { name: "Bullpup Rifle", img: "bullpuprifle.png", weapon: "bullpuprifle", type: "rifle" },
    { name: "Bullpup Rifle MK II", img: "bullpuprifle_mk2.png", weapon: "bullpuprifle_mk2", type: "rifle" },
    { name: "Compact Rifle", img: "compactrifle.png", weapon: "compactrifle", type: "rifle" },

    // Shotguns
    { name: "Pump Shotgun", img: "pumpshotgun.png", weapon: "pumpshotgun", type: "shotgun" },
    { name: "Pump Shotgun MK II", img: "pumpshotgun_mk2.png", weapon: "pumpshotgun_mk2", type: "shotgun" },
    { name: "Sawed-Off Shotgun", img: "sawnoffshotgun.png", weapon: "sawnoffshotgun", type: "shotgun" },
    { name: "Assault Shotgun", img: "assaultshotgun.png", weapon: "assaultshotgun", type: "shotgun" },
    { name: "Bullpup Shotgun", img: "bullpupshotgun.png", weapon: "bullpupshotgun", type: "shotgun" },
    { name: "Musket", img: "musket.png", weapon: "musket", type: "shotgun" },
    { name: "Heavy Shotgun", img: "heavyshotgun.png", weapon: "heavyshotgun", type: "shotgun" },
    { name: "Double Barrel Shotgun", img: "dbshotgun.png", weapon: "dbshotgun", type: "shotgun" },
    { name: "Auto Shotgun", img: "autoshotgun.png", weapon: "autoshotgun", type: "shotgun" },

    // Sniper Rifles
    { name: "Heavy Sniper", img: "heavysniper.png", weapon: "heavysniper", type: "sniper" },
    { name: "Heavy Sniper MK II", img: "heavysniper_mk2.png", weapon: "heavysniper_mk2", type: "sniper" },
    { name: "Marksman Rifle", img: "marksmanrifle.png", weapon: "marksmanrifle", type: "sniper" },
    { name: "Marksman Rifle MK II", img: "marksmanrifle_mk2.png", weapon: "marksmanrifle_mk2", type: "sniper" },

    // Machine Guns
    { name: "MG", img: "mg.png", weapon: "mg", type: "mg" },
    { name: "Combat MG", img: "combatmg.png", weapon: "combatmg", type: "mg" },
    { name: "Combat MG MK II", img: "combatmg_mk2.png", weapon: "combatmg_mk2", type: "mg" },
    { name: "Gusenberg Sweeper", img: "gusenberg.png", weapon: "gusenberg", type: "mg" }
];

export default guns;