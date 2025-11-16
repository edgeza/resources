Config = {}
Config.MaximumLevel = 10


-- Localization of titles are stored in locales/xx.json
-- Title for player's hunting progress / title : min level requirement to earn the title
Config.Title = {
    beginner = 1,
    novice = 2,
    apprentice = 4,
    adept = 6,
    expert = 8,
    master = 10,
}

Config.IncreaseAmountByQuality = true -- Enable/disable quality-based bonus for meat & hide amounts (quality 1 = 0 bonus, quality 2 = 1 bonus, quality 3 = 2 bonus)
Config.AnimalRewards = {
   ['deer'] = {
        meat = {
            item = 'deer_meat',
            parts = {
                beef = { 
                    amount = 5, 
                    model = 'propk_deer_beef_raw', 
                    item = 'deer_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'deer_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    model = 'propk_deer_rib_raw', 
                    item = 'deer_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'deer_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    model = 'propk_deerleg_raw', 
                    item = 'deer_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deerleg_cooked',
                        cookedItem = 'deer_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['rabbit'] = {
        meat = {
            item = 'rabbit_meat',
            parts = {
                body = { 
                    amount = 5, 
                    model = 'propk_rabbit_raw', 
                    item = 'rabbit_body',
                    cook = {
                        method = {'stick', 'grill'},
                        cookingTime = 20,
                        cookedModel = 'propk_rabbit_cooked',
                        cookedItem = 'rabbit_body_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    model = 'propk_rabbit_leg_raw', 
                    item = 'rabbit_leg',
                    cook = {
                        method = {'stick', 'grill'},
                        cookingTime = 5,
                        cookedModel = 'propk_rabbit_leg_cooked',
                        cookedItem = 'rabbit_leg_cooked'
                    }
                },
                beef = { 
                    amount = 5, 
                    item = 'rabbit_beef',
                    cook = {
                        method = {'stick', 'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'rabbit_beef_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['bear'] = {
        meat = {
            item = 'bear_meat',
            parts = {
                beef = { 
                    amount = 5, 
                    model = 'propk_bear_beef_raw', 
                    item = 'bear_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_bear_beef_cooked',
                        cookedItem = 'bear_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    model = 'propk_bear_rib_raw', 
                    item = 'bear_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_bear_rib_cooked',
                        cookedItem = 'bear_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    model = 'propk_bear_arm_raw', 
                    item = 'bear_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_bear_arm_cooked',
                        cookedItem = 'bear_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['redpanda'] = {
        meat = {
            item = 'redpanda_meat',
            parts = {
                body = { 
                    amount = 5, 
                    model = 'propk_redpanda_raw', 
                    item = 'redpanda_body',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_redpanda_cooked',
                        cookedItem = 'redpanda_body_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    model = 'propk_redpanda_arm_raw', 
                    item = 'redpanda_leg',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_redpanda_arm_cooked',
                        cookedItem = 'redpanda_leg_cooked'
                    }
                },
                beef = { 
                    amount = 5, 
                    item = 'redpanda_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'redpanda_beef_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['boar'] = {
        meat = {
            item = 'boar_meat',
            parts = {
                leg = { 
                    amount = 4, 
                    model = 'propk_pork_shank_raw', 
                    item = 'boar_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_pork_shank_cooked',
                        cookedItem = 'boar_leg_cooked'
                    }
                },
                beef = { 
                    amount = 3, 
                    model = 'propk_pork_beef_raw', 
                    item = 'boar_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_pork_beef_cooked',
                        cookedItem = 'boar_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    item = 'boar_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'boar_rib_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['coyote'] = {
        meat = {
            item = 'coyote_meat',
            parts = {
                beef = { 
                    amount = 5, 
                    item = 'coyote_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'coyote_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    item = 'coyote_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'coyote_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    item = 'coyote_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deerleg_cooked',
                        cookedItem = 'coyote_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['mtlion'] = {
        meat = {
            item = 'mtlion_meat',
            parts = {
                beef = { 
                    amount = 3, 
                    item = 'mtlion_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'mtlion_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    item = 'mtlion_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'mtlion_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    item = 'mtlion_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deerleg_cooked',
                        cookedItem = 'mtlion_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['lion'] = {
        meat = {
            item = 'lion_meat',
            parts = {
                beef = { 
                    amount = 5, 
                    item = 'lion_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'lion_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    item = 'lion_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'lion_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    item = 'lion_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deerleg_cooked',
                        cookedItem = 'lion_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['oryx'] = {
        meat = {
            item = 'oryx_meat',
            parts = {
                beef = { 
                    amount = 5, 
                    item = 'oryx_beef',
                    cook = {
                        method = {'grill', 'stick'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'oryx_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    item = 'oryx_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'oryx_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    item = 'oryx_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deerleg_cooked',
                        cookedItem = 'oryx_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    ['antelope'] = {
        meat = {
            item = 'antelope_meat',
            parts = {
                beef = { 
                    amount = 5, 
                    item = 'antelope_beef',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_beef_cooked',
                        cookedItem = 'antelope_beef_cooked'
                    }
                },
                rib = { 
                    amount = 2, 
                    item = 'antelope_rib',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deer_rib_cooked',
                        cookedItem = 'antelope_rib_cooked'
                    }
                },
                leg = { 
                    amount = 4, 
                    item = 'antelope_leg',
                    cook = {
                        method = {'grill'},
                        cookingTime = 10,
                        cookedModel = 'propk_deerleg_cooked',
                        cookedItem = 'antelope_leg_cooked'
                    }
                },
            },
        },
        hide = {
            amount = 1
        },
    },
    
}