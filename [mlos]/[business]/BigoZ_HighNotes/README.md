Information about HighNotes MLO

Project Developed by NoNick Dev Team & BigoZ

If you have a problem, create a Ticket on our Discord Server: https://discord.gg/fyF9UFKPZj

----------------------------------------------------------------------------
INSTALLATION:

1) Drag and Drop the resource "BigoZ_HighNotes" to your resources folder.

2) Start the resource inside your config.cfg
    `ensure cfx-bigoz-mapdata`
    `ensure BigoZ_HighNotes`

3) Clear your Server Cache

4) Restart your Server

5) Done!

----------------------------------------------------------------------------
INFO:
Location: 
-837.2083, -228.415848, 36.32132

Doors:
bigoz_rooftop_singledoor				2976117350
bigoz_rooftop_maindoor					797296987
bigoz_rooftop_toilet_door_l				2816993434
bigoz_rooftop_toilet_door_r				1855354364
bigoz_rooftop_lab_slidingdoor			3943405482
bigoz_rooftop_recstudio_slidingdoor		720324072

----------------------------------------------------------------------------
FAQ:

- If bob74_ipl is already present on the server, can I remove some files?
Answer: Delete `client.lua`,`common.lua`,`musicrooftop.lua` and inside `fxmanifest.lua` file, replace
this
`
client_scripts {
    'bigoz_highnotes_entityset.lua',
    'bigoz_highnotes_elevator.lua',
    'musicrooftop.lua',
    'client.lua',
    'common.lua'
}
`
with this
`
client_scripts {
    'bigoz_highnotes_entityset.lua',
    'bigoz_highnotes_elevator.lua'
}
`


- How can I edit the logos?
Answer: As for the 2D logos, it will be possible to change the textures by opening the .ytd files via openIV
		As for the 3D logos, you will find all the non-encrypted models inside the [logos] folder, they will be editable via Blender or 3dsMax.
		If you need help, don't hesitate to open a Ticket on our Discord server


- I have my own elevator script, how can I disable yours?
Answer: Delete the `bigoz_highnotes_elevator.lua` file and inside `fxmanifest.lua` file, replace
this
`
client_scripts {
    'bigoz_highnotes_elevator.lua',
    'musicrooftop.lua',
    'client.lua',
    'common.lua'
}
`
with this
`
client_scripts {
    'musicrooftop.lua',
    'client.lua',
    'common.lua'
}
`

----------------------------------------------------------------------------
HOTFIX:

Version: 1.0.4
-Added xmas variant

Version: 1.0.3
-Fixed an fps drop into the main room.

Version: 1.0.2
-Removed dependencie with bob74_ipl

Version: 1.0.1
-Removed some flying dirt at the entrance

Version: 1.0.0
-Map Release