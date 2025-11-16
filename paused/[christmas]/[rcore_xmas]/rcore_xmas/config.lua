Config = {
    Debug = false, -- [true/false] - Enables debug mode, which will print additional information to the console.

    -- Locale = 'en',                        -- Locale for translations (locales/[locale].lua)

    Framework = Framework.QBCore,            -- [ESX - es_extended, QBCore - qb-core, Standalone - standalone]
    Inventory = Inventory.QS,             -- [OX - ox_inventory, QB - qb-inventory, QS - qs-inventory, MF - mf-inventory, PS - ps-inventory, LJ - lj-inventory, CORE = core_inventory]
    Target = Target.OX,                   -- [NONE - none (pressing E), OX - ox_target, QB - qb-target, Q - qtarget]
    Database = Database.OX,      -- [OX - ox_mysql, MYSQL_ASYNC - mysql-async, GHMATTI - ghmattimysql]

    XmasWeather = false,                   -- [true/false] - Enables Xmas weather.
    EnableVehicleTrailsEverywhere = false, -- [true/false] - Enables vehicle trails everywhere.
    EnablePedFootstepsEverywhere = false,  -- [true/false] - Enables ped footsteps everywhere.
    WaterFreezes = 3.0,                   -- [float] - The strength of the frozen water effect. 0.0 = no frozen water, 3.0 = completely frozen water.
    SnowIntensity = 0.5,                  -- [float] - The intensity of the snow effect. 0.0 = no snow, 1.0 = heavy snow.

    AcePermsInsteadOfFramework = false,   -- [true/false] - Enables ACE permissions instead of framework permissions.

    FrameworkAdminGroups = {
        [Framework.ESX] = { 'superadmin', 'admin' },
        [Framework.QBCore] = { 'god', 'admin' },
    },

    CancelProgressBar = {
        Key = 194,
        Label = 'INPUT_FRONTEND_RRIGHT',
        Text = 'Cancel',
    },

    Placer = {
        Place = 'Place',
        Cancel = 'Cancel',
        SlowRotation = 'Slow rotation',
        LeftRotation = 'Left rotation',
        RightRotation = 'Right rotation',
    },

    Select = {
        Select = 'Select',
        Cancel = 'Cancel',
        Up = 'Up',
        Down = 'Down',
    },

    Snowballs = {           -- [table] - Snowballs
        Pickup = {
            Enabled = true, -- [true/false] - Enables snowball pickup.
            Bind = {
                Description = 'Pickup snowball',
                Controls = 'keyboard',
                Key = 'k',
            },
            Animation = {
                Dict = 'anim@mp_snowball', -- [string] - Animation dictionary.
                Name = 'pickup_snowball',  -- [string] - Animation name.
            },
            Receive = {
                Item = 'WEAPON_SNOWBALL',
                -- Weapon = `WEAPON_SNOWBALL`,
                Amount = 2,
            },
            Notifications = {
                Interior = 'You can not pick up snowballs in an interior.',
                Cooldown = 'You are on cooldown. Wait before you can pick up another snowball!',
                NotFree = 'You can not pick up snowballs while doing something else!',
            }
        }
    },

    PresentHunt = {                                       -- [table] - Present hunt
        Enabled = true,                                   -- [true/false] - Enables present hunt.
        Model = `bzzz_xmas23_convert_tree_gift`,          -- [hash] - Model of the present.
        DeleteAfterCollect = true,                        -- [true/false] - Delete present after collecting.
        Collect = {
            Radius = 2.0,                                 -- [float] - Radius of the collection area (Work only with Target.NONE)
            HelpText = {                                  -- Works only with Target.NONE
                Enabled = true,                           -- [true/false] - Enables help text.
                Text = '~INPUT_CONTEXT~ Collect present', -- [string] - Help text.
            },
            Target = {
                label = 'Collect present',
                distance = 1.5,
                icon = 'fa-solid fa-gift' -- https://fontawesome.com/v5.15/icons?d=gallery&p=2&m=free
            },
            Animation = {
                Dict = 'anim@mp_snowball', -- [string] - Animation dictionary.
                Name = 'pickup_snowball',  -- [string] - Animation name.
            },
        },
        Rewards = {                                -- [table] - Loot table for rewards
            {
                item = 'cash',                     -- [string] - Item name.
                amount = { min = 100, max = 200 }, -- [int/table] - Amount of the item. If table is used, it will generate a random number between min and max.
                chance = 900,                      -- [int] - Chance of getting the item.
                label = 'Cash',                    -- [string] - Label of the item.
            },
            {
                item = 'pistol',
                amount = 1,
                chance = 10,
            },
            {
                item = 'meth',
                amount = { min = 1, max = 3 },
                chance = 20,
            },
            {
                item = 'weed',
                amount = { min = 3, max = 8 },
                chance = 10,
            }
        },
        Notifications = { -- [table] - Notifications
            Error = 'An error occurred while collecting the present!',
            InventoryError = 'An error occurred while adding the reward to your inventory!',
            RewardNotFound = 'Reward not found!',
            RewardGiven = 'You got %sx %s!',
        },
    },

    Trees = {                                             -- [table] - Christmas trees
        Persist = {                                       -- [table] - Persistent trees
            Enabled = true,                               -- [true/false] - Enables if the trees should be persistent and be available after server restart AND is allowed to open GIFTS STASH.
            PerPlayerLimit = 2,                           -- [int/false] - How many trees can a player have at the same time (false = unlimited)
        },
        Build = {                                         -- [table] - Tree building
            Enabled = true,                               -- [true/false] - Enables tree building / placing
            InteriorOnly = false,                         -- [true/false] - Enables tree building only in interiors
            Models = {                                    -- [table] - Tree models
                Undecored = `bzzz_xmas23_convert_tree_a`, -- [hash] - Undecored tree model
                Decored = `bzzz_xmas23_convert_tree_b`    -- [hash] - Decored tree model
            },
            Command = 'tree',                             -- [string] - Command to start building
            Item = 'xmas_tree',                           -- [string/nil] - Item to start building
        },
        Stash = {
            Enabled = true,                                   -- [true/false] - Enables gifts stash
            Title = 'Tree Gifts (%s)',                        -- [string] - Title of the stash (%s is used for the tree ID)
            Slots = 10,                                       -- [int] - Slots of the stash
            MaxWeight = 1000.0,                               -- [float] - Max weight of the stash
            OxInventoryHook = {
                OnlyGifts = true,                             -- [true/false] - Enables only gift items in the stash
                GiftsOnGround = {
                    Enabled = true,                           -- [true/false] - Enables gifts on the ground if something is in the stash
                    Model = `bzzz_xmas23_convert_tree_gifts`, -- [hash] - Model of the gift
                },
            }
        },
        Decorate = {
            ProgressTime = 5000,                 -- [int] - Time of the progress bar
            ProgressText = 'Decorating tree...', -- [string] - Text of the progress bar
            Animation = {
                Dict = 'mp_car_bomb',
                Name = 'car_bomb_mechanic'
            },
            Required = {
                { item = 'xmas_star',  amount = 1 }, -- [table] - Required items to decorate the tree
                { item = 'xmas_decor', amount = 5 },
            }
        },
        Control = {
            Radius = 2.0,
            HelpText = {        -- Works only with Target.NONE
                Enabled = true, -- [true/false] - Enables help text.
            },
            Decorate = {
                Text = '~INPUT_CONTEXT~ Decorate tree', -- [string] - Help text.
                Target = {
                    label = 'Decorate tree',
                    icon = 'fa-solid fa-paint-roller', -- https://fontawesome.com/v5.15/icons?d=gallery&p=2&m=free
                },
            },
            GiftsStash = {
                Text = '~INPUT_CONTEXT~ Open gifts stash',
                Target = {
                    label = 'Open gifts stash',
                    icon = 'fa-solid fa-gifts',
                },
            },
            Delete = {
                Text = '~INPUT_CELLPHONE_OPTION~ Delete tree',
                Target = {
                    label = 'Delete tree',
                    icon = 'fa-solid fa-trash-alt',
                },
            },
        },
        Notifications = {
            Error = 'An error occurred while building the tree!',
            InventoryError = 'An error occurred while manipulating with your inventory!',
            PersistLimit = 'You have too many trees built! Destroy one of them first!',
            TreeBuilt = 'You built the tree!',
            StashOnlyGifts = 'You can only put gifts in the stash!',
            NotFree = 'You can not do any other activities / sit in vehicle during building tree!',
            Interior = 'You can not build a tree in an interior!',
            AlreadyBuilding = 'You already building a tree!',
            Cancelled = 'You cancelled building the tree!',
            Failed = 'You can not build here!',
            TreeDestroyed = 'You destroyed the tree!',
            TreeDecorated = 'You decorated the tree!',
            EnoughItems = 'You do not have enough items to decorate the tree!',
            DecorateFailed = 'You cancelled decoration of the tree!',
            AdminCancelled = 'You cancelled deleting tree.',
            AdminWrongArchetype = 'You are not looking at the tree!',
            AdminNoTree = 'This is not a XMAS tree!',
            NoPermission = 'You do not have permission to do this!',
            NoItem = 'You do not have any trees to build!',
        }
    },

    Gifts = {
        Enabled = true,                        -- [true/false] - Enables gifts packaging
        Item = 'xmas_gift',                    -- [string] - Item to start packaging
        PackedItem = 'xmas_packed_gift',       -- [string] - Item to receive after packaging
        PackedItemDescription = 'Nametag: %s', -- [string] - Description of the gift in the inventory (%s is used for the nametag)
        Command = 'packgift',                  -- [string] - Command to start packaging
        Inventory = {
            UnpackedTitle = 'Unpacked Gift',   -- [string] - Title of the unpacked gift for preparing gift
            PackedTitle = 'Gift (%s)',         -- [string] - Title of the packed gift (%s is used for the nametag)
            Slots = 5,
            MaxWeight = 1000.0,
        },
        Unpack = {
            WaitForChristmas = true, -- [true/false] - Players can open packed gifts only after specified date
            Date = {
                day = 24,
                month = 12,
            }
        },
        Notifications = {
            NoItem = 'You do not have any gifts to pack!',
            NoGifts = 'You do not have any items in unpacked gifts!',
            NotAdded = 'Packed gift can not be added to your inventory! Do you have space?',
            NotChristmas = 'You can open packed gifts only after / during Christmas!',
            Unpacked = 'You unpacked the gift!',
            Packed = 'You packed the gift!',
        }
    },

    Snowman = {                           -- [table] - Snowman building
        Enabled = true,                   -- [true/false] - Enables snowman building
        Command = 'snowman',              -- [string] - Command to start building
        Model = `bzzz_maku_snowmen_full`, -- [hash] - Snowman model
        Place = {                         -- [table] - Snowman placing
            Radius = 1.0,                 -- [float] - Radius of the parts building area (Work only with Target.NONE)
            HelpText = {                  -- Works only with Target.NONE
                Enabled = true,
                Text = '~INPUT_CONTEXT~ Complete %s part~n~~INPUT_VEH_HEADLIGHT~ Cancel building',
            },
            Target = {
                label = 'Complete %s part',
                icon = 'fa-solid fa-hammer', -- https://fontawesome.com/v5.15/icons?d=gallery&p=2&m=free
            },
            CancelTarget = {
                label = 'Cancel building',
                icon = 'fa-solid fa-times',
            },
        },
        FireDestroyable = true, -- [true/false] - Is the fire destroyable?
        Notifications = {       -- [table] - Notifications
            Error = 'An error occurred while building the snowman!',
            InventoryError = 'An error occurred while removing the required items from your inventory!',
            EnoughtItem = 'You do not have enough items to build this part!',
            PartNotFound = 'Part not found!',
            PartBuilt = 'You built the %s part!',
            SnowmanBuilt = 'You built the snowman!',
            NotFree = 'You can not do any other activities / sit in vehicle during building snowman!',
            Interior = 'You can not pick up snowballs in an interior.',
            AlreadyBuilding = 'You already building a snowman!',
            Cancelled = 'You cancelled building the snowman!',
            Failed = 'You can not build here!',
            AdminCancelled = 'You cancelled deleting snowman or snowman part.',
            AdminWrongArchetype = 'You are not looking at the snowman or snowman part!',
            AdminNoSnowman = 'This is not a snowman or snowman part!',
            NoPermission = 'You do not have permission to do this!',
        },
        BuiltModel = `bzzz_maku_snowmen_full`,
        Plan = {                                  -- [table] - Snowman building plan / "blueprint"
            [SNOWMAN_PART_BODY] = {               -- [string] - Part name
                Body = true,                      -- [true/false] - Is this part the body?
                Model = `bzzz_maku_snowmen_body`, -- [hash] - Part model
                Required = {                      -- [table] - Required items to build this part
                    { item = 'WEAPON_SNOWBALL', amount = 5 },
                },
                Next = {
                    [SNOWMAN_PART_HEAD] = {
                        Model = `bzzz_maku_snowmen_head`,
                        Offset = { -- [table] - Offset of the part
                            z = 0.95
                        },
                        Required = {
                            { item = 'WEAPON_SNOWBALL', amount = 5 },
                        },
                        Next = {
                            [SNOWMAN_PART_SCARF] = {
                                Model = `bzzz_maku_snowmen_scarf`,
                                Required = {
                                    { item = 'WEAPON_SNOWBALL', amount = 5 },
                                },
                                Offset = {
                                    r = 0.02,
                                    z = 0.63
                                },
                                Target =
                                    SNOWMAN_PART_BODY -- [string] - Attach target (third-eye) to this part if it's too small
                            },
                            [SNOWMAN_PART_HAT] = {
                                Model = `bzzz_maku_snowmen_hat`,
                                Required = {
                                    { item = 'WEAPON_SNOWBALL', amount = 5 },
                                },
                                Offset = {
                                    r = 0.05, -- [float] - Radius of the circle for counting the offset
                                    h = 90.0, -- [float] - Added degree to the rotation
                                    z = 1.4   -- [float] - Height offset
                                }
                            },
                            [SNOWMAN_PART_NOSE] = {
                                Model = `bzzz_maku_snowmen_nose`,
                                Required = {
                                    { item = 'WEAPON_SNOWBALL', amount = 5 },
                                },
                                Offset = {
                                    r = -0.3,
                                    h = 90.0,
                                    z = 1.2
                                }
                            },
                            [SNOWMAN_PART_FACE] = {
                                Model = `bzzz_maku_snowmen_face`,
                                Required = {
                                    { item = 'WEAPON_SNOWBALL', amount = 5 },
                                },
                                Offset = {
                                    z = 0.32
                                },
                                Target = SNOWMAN_PART_BODY
                            },
                        }
                    },
                    [SNOWMAN_PART_HANDS] = {
                        Model = `bzzz_maku_snowmen_hands`,
                        Required = {
                            { item = 'WEAPON_SNOWBALL', amount = 5 },
                        },
                        Offset = {
                            z = 0.8
                        },
                        Target = SNOWMAN_PART_BODY
                    }
                }
            },
        }
    }
}
