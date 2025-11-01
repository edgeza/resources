-----------------------------------------------------------------------------------------------------------
-------------------------------------------- VEHICLE TUNING -----------------------------------------------
-----------------------------------------------------------------------------------------------------------
--
-- Here you can create, edit and remove various tuning parts. The changes they make to the handling is all
-- in here, so feel free to modify as you wish. PLEASE bear in mind that if 2 different tuning options
-- modify the same handling values, and are set to overwrite, they could overwrite each other unpredictably
-- Either set the values to NOT overwrite, or make sure that different tuning parts modify unique parts of
-- the handling to prevent undesired results. 
--
-- Here is a guide on what different options mean to help you customise your tuning parts.
--
-----------------------------------------------------------------------------------------------------------
--  name                      The name of the modification that will be shown in the tablet.
-----------------------------------------------------------------------------------------------------------
--  info                      Optional, but you can provide additional info that will show in the UI when
--                            clicking the info icon when they are selecting an upgrade. It could be used 
--                            to warn mechanics of vehicles an upgrade shouldn't be applied on, or results
--                            from your testing of handling values.
-----------------------------------------------------------------------------------------------------------
--  itemName                  For mechanics set up to use an item for upgrades, this is the name of the
--                            required item.
-----------------------------------------------------------------------------------------------------------
--  price                     For mechanics set up to purchase upgrades, this will be the cost to the
--                            mechanic to apply the upgrade.
-----------------------------------------------------------------------------------------------------------
--  audioNameHash             Any in-game vehicle name, or addon sound pack name (ENGINE SWAPS ONLY!)
-----------------------------------------------------------------------------------------------------------
--  handling                  Add/remove handling attributes & values.
--                            More help & info on handling values: https://gtamods.com/wiki/Handling.meta
-----------------------------------------------------------------------------------------------------------
--  handlingApplyOrder        The order in which this tuning option should be applied. This is useful when
--                            tuning options have overlapping handling values! Provide a priority number,
--                            and the lowest numbers will be applied first.
-----------------------------------------------------------------------------------------------------------
--  handlingOverwritesValues  Whether the handling values provided should overwrite the vehicle's existing
--                            values, or whether they should modify the vehicle's existing values. This
--                            also works for negative values too.
--                           
--                            For example: a vehicle's current fDriveInertia value is at 1.0
--                               true  = a value of 0.5 sets fDriveInertia to 0.5
--                               false = a value of 0.5 will mean [1.0 + 0.5] and set fDriveInertia to 1.5
-----------------------------------------------------------------------------------------------------------
-- restricted (optional)      Can either be false (unrestricted) "electric" or "combustion"
-----------------------------------------------------------------------------------------------------------
-- blacklist                  List of archetype names (spawn codes) that cannot use this modification
-----------------------------------------------------------------------------------------------------------
-- minGameBuild               Functionality restricted to a certain game build, such as manual gearboxes
-----------------------------------------------------------------------------------------------------------

Config.Tuning = {
  --
  -- ENGINE SWAPS
  -- You can customise, or add new engine swap options here.
  --
  engineSwaps = {
    [1] = {
      name = "4-Stroke Engine",
      icon = "engine.svg",
      info = "Basic 4-stroke engine with moderate power and efficiency. Perfect for everyday driving.",
      itemName = "4stroke_engine",
      price = 7500,
      audioNameHash = "focus2003",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.10,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 100,
        fClutchChangeRateScaleUpShift = 3.5,
        fClutchChangeRateScaleDownShift = 3.5
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "5-Stroke Engine",
      icon = "engine.svg",
      info = "Advanced 5-stroke engine with improved efficiency and power delivery.",
      itemName = "5stroke_engine",
      price = 12500,
      audioNameHash = "ea888",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.15,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 120,
        fClutchChangeRateScaleUpShift = 4.0,
        fClutchChangeRateScaleDownShift = 4.0
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [3] = {
      name = "V6 3.0L",
      icon = "engine.svg",
      info = "Smooth V6 engine with balanced power and fuel efficiency. Great for sports sedans.",
      itemName = "v6_engine",
      price = 27500,
      audioNameHash = "aq14nisvq37vhrt",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.20,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 140,
        fClutchChangeRateScaleUpShift = 4.2,
        fClutchChangeRateScaleDownShift = 4.2
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom", "energytenereride_tuner", "energytenereride_onelife", "energytenereride_east", "energytenereride_Bennys", "dlshin", "dlmanch", "dlemsb", "kampfer", "bati901", "polbike"}
    },
    [4] = {
      name = "6-Cylinder Inline",
      icon = "engine.svg",
      info = "Classic inline-6 engine with smooth power delivery and legendary reliability.",
      itemName = "inline6_engine",
      price = 10000,
      audioNameHash = "aqtoy2jzstock",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.25,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 160,
        fClutchChangeRateScaleUpShift = 4.3,
        fClutchChangeRateScaleDownShift = 4.3
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom", "energytenereride_tuner", "energytenereride_onelife", "energytenereride_east", "energytenereride_Bennys", "dlshin", "dlmanch", "dlemsb", "kampfer", "bati901", "polbike"}
    },
    [5] = {
      name = "V8 6.5L",
      icon = "engine.svg",
      info = "Naturally aspirated 6.5L V8. Has awesome backfires and a crackling sound as you let off the gas. Sure to impress.",
      itemName = "v8_engine",
      price = 32500,
      audioNameHash = "jugular",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.30,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 180,
        fClutchChangeRateScaleUpShift = 4.5,
        fClutchChangeRateScaleDownShift = 4.5
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom", "energytenereride_tuner", "energytenereride_onelife", "energytenereride_east", "energytenereride_Bennys", "dlshin", "dlmanch", "dlemsb", "kampfer", "bati901", "polbike"}
    },
    [6] = {
      name = "V10 5.2L",
      icon = "engine.svg",
      info = "High-revving V10 engine with incredible power and an exotic sound. Perfect for supercars.",
      itemName = "v10_engine",
      price = 42500,
      audioNameHash = "lambov10",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.32,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 190,
        fClutchChangeRateScaleUpShift = 4.8,
        fClutchChangeRateScaleDownShift = 4.8
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom", "energytenereride_tuner", "energytenereride_onelife", "energytenereride_east", "energytenereride_Bennys", "dlshin", "dlmanch", "dlemsb", "kampfer", "bati901", "polbike"}
    },
    [7] = {
      name = "V12 6.0L",
      icon = "engine.svg",
      info = "A huge 6L V12 monster. Can reach speeds of over 130mph, be realistic and only put this in vehicles that could realistically fit a V12.",
      itemName = "v12_engine",
      price = 50000,
      audioNameHash = "f50gteng",
      handlingOverwritesValues = true,
      handlingApplyOrder = 1,
      handling = {
        fInitialDriveForce = 0.35,
        fDriveInertia = 1.0,
        fInitialDriveMaxFlatVel = 200,
        fClutchChangeRateScaleUpShift = 4.5,
        fClutchChangeRateScaleDownShift = 4.5
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom", "energytenereride_tuner", "energytenereride_onelife", "energytenereride_east", "energytenereride_Bennys", "dlshin", "dlmanch", "dlemsb", "kampfer", "bati901", "polbike"}
    }
  },

  -- TYRES
  -- You can customise, or add new tyre options here.
  --
  tyres = {
    [1] = {
      name = "Slicks",
      icon = "engine.svg",
      info = false,
      itemName = "slick_tyres",
      price = 12500,
      handlingOverwritesValues = true,
      handlingApplyOrder = 2,
      handling = {
        fTractionCurveMin = 3.95,
        fTractionCurveMax = 3.75
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Semi-slicks",
      icon = "engine.svg",
      info = false,
      itemName = "semi_slick_tyres",
      price = 12500,
      handlingOverwritesValues = true,
      handlingApplyOrder = 2,
      handling = {
        fTractionCurveMin = 2.65,
        fTractionCurveMax = 2.45
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [3] = {
      name = "Offroad",
      icon = "engine.svg",
      info = false,
      itemName = "offroad_tyres",
      price = 12500,
      handlingOverwritesValues = true,
      handlingApplyOrder = 2,
      handling = {
        fTractionLossMult = 0.3
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- BRAKES
  -- You can customise, or add new tyre options here.
  --
  brakes = {
    [1] = {
      name = "Ceramic",
      icon = "engine.svg",
      info = "Standard ceramic brakes with improved stopping power over stock",
      itemName = "ceramic_brakes",
      price = 12000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 3,
      handling = {
        fBrakeForce = 1.0
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- DRIVETRAINS
  -- You can customise, or add new drivetain options here.
  --
  drivetrains = {
    [1] = {
      name = "AWD",
      icon = "engine.svg",
      info = false,
      itemName = "awd_drivetrain",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 4,
      handling = {
        fDriveBiasFront = 0.5
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "RWD",
      icon = "engine.svg",
      info = false,
      itemName = "rwd_drivetrain",
      price = 25000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 4,
      handling = {
        fDriveBiasFront = 0.2
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- TURBOCHARGING
  -- Note: This category is unique as it just enables/disables mod 18 (the standard GTA turbocharging option)
  -- You can't add additional turbocharging options, you can only adjust/remove the existing one.
  -- You can't add any handling changes. Make new items/other categories for that.
  --
  turbocharging = {
    [1] = {
      name = "Turbocharging",
      icon = "engine.svg",
      info = false,
      itemName = "turbocharger",
      price = 27500,
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- DRIFT TUNING
  -- You can't add additional drift tuning options, you can only adjust/remove the existing one.
  --
  driftTuning = {
    [1] = {
      name = "Drift Tuning",
      icon = "engine.svg",
      info = false,
      itemName = "drift_tuning_kit",
      price = 30000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 15,
      handling = {
        fMass = 1500,
        fInitialDragCoeff = 15.50,
        fInitialDriveForce = 1.9,
        fInitialDriveMaxFlatVel = 200.00,
        fSteeringLock = 57.00,
        fTractionCurveMax = 1.0,
        fTractionCurveMin = 1.45,
        fTractionCurveLateral = 35.00,
        fLowSpeedTractionLossMult = 0.5,
        fTractionBiasFront = 0.45,
        nInitialDriveGears = 6,
        fDriveBiasFront = 0.00,
        fClutchChangeRateScaleUpShift = 5.00,
        fClutchChangeRateScaleDownShift = 5.00,
        fBrakeForce = 4.85,
        fBrakeBiasFront = 0.67,
        fHandBrakeForce = 3.50,
        fTractionSpringDeltaMax = 0.15,
        fTractionLossMult = 1.00,
        fSuspensionForce = 2.80,
        fSuspensionCompDamp = 1.4,
        fSuspensionReboundDamp = 2.20,
        fSuspensionUpperLimit = 0.06,
        fSuspensionLowerLimit = -0.05,
        fSuspensionRaise = 0.00,
        fSuspensionBiasFront = 0.50
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },
  --
  -- RACE TUNING
  -- Different racing setups for various driving styles
  --
  raceTuning = {
    [1] = {
      name = "Drag Tune",
      icon = "engine.svg",
      info = "Optimized for straight-line acceleration and quarter-mile runs. Reduces top speed but maximizes launch power.",
      itemName = "drag_tuning_kit",
      price = 22500,
      handlingOverwritesValues = true,
      handlingApplyOrder = 6,
      handling = {
        fInitialDriveForce = 1.0,
        fInitialDriveMaxFlatVel = 320,
        fDriveInertia = 1.1,
        fTractionCurveMax = 1.5,
        fTractionCurveMin = 1.0,
        fTractionCurveLateral = 15.0,
        fSteeringLock = 15.0,
        fTractionBiasFront = 0.3,
        fTractionSpringDeltaMax = 0.05,
        fLowSpeedTractionLossMult = 0.3,
        fTractionLossMult = 0.0,
        fSuspensionForce = 2.5,
        fSuspensionCompDamp = 1.5,
        fSuspensionReboundDamp = 1.0,
        fSuspensionUpperLimit = 0.08,
        fSuspensionLowerLimit = -0.08,
        fSuspensionBiasFront = 0.45,
        fAntiRollBarForce = 0.3,
        fAntiRollBarBiasFront = 0.5,
        fRollCentreHeightFront = 0.3,
        fRollCentreHeightRear = 0.0,
        fBrakeForce = 0.6,
        fBrakeBiasFront = 0.6,
        fHandBrakeForce = 0.3,
        fClutchChangeRateScaleUpShift = 8.0,
        fClutchChangeRateScaleDownShift = 2.0
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- STEERING RACK
  -- Different steering setups for various driving preferences
  --
  steeringRack = {
    [1] = {
      name = "Quick Ratio Steering",
      icon = "engine.svg",
      info = "Faster steering response for precise control. Requires less steering input for sharp turns.",
      itemName = "quick_ratio_steering",
      price = 9000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 7,
      handling = {
        fSteeringLock = 15.0,
        fTractionCurveMax = 1.0,
        fTractionCurveMin = 1.0
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Standard Steering",
      icon = "engine.svg",
      info = "Balanced steering ratio for everyday driving. Good balance between control and comfort.",
      itemName = "standard_steering",
      price = 6000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 7,
      handling = {
        fSteeringLock = 5.0,
        fTractionCurveMax = 0.5,
        fTractionCurveMin = 0.5
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [3] = {
      name = "Slow Ratio Steering",
      icon = "engine.svg",
      info = "Slower steering response for stability at high speeds. Requires more input but provides better control.",
      itemName = "slow_ratio_steering",
      price = 7500,
      handlingOverwritesValues = false,
      handlingApplyOrder = 7,
      handling = {
        fSteeringLock = -5.0,
        fTractionCurveMax = -1.0,
        fTractionCurveMin = -1.0
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [4] = {
      name = "Race Steering",
      icon = "engine.svg",
      info = "Ultra-responsive steering for track use. Maximum precision and feedback for racing conditions.",
      itemName = "race_steering",
      price = 12500,
      handlingOverwritesValues = false,
      handlingApplyOrder = 7,
      handling = {
        fSteeringLock = 10.0,
        fTractionCurveMax = 1.5,
        fTractionCurveMin = 1.5
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- SUSPENSION TUNING
  -- Different suspension setups for various driving styles
  --
  suspension = {
    [1] = {
      name = "Street Suspension",
      icon = "engine.svg",
      info = "Soft suspension setup optimized for comfort and fuel efficiency during daily driving.",
      itemName = "street_suspension",
      price = 5000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 8,
      handling = {
        fSuspensionForce = 0.1,
        fSuspensionDamping = 0.05,
        fSuspensionCompDamp = 0.05,
        fSuspensionReboundDamp = 0.05,
        fAntiRollBarForce = 0.1,
        fPetrolConsumptionRate = -0.02
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Sport Suspension",
      icon = "engine.svg",
      info = "Balanced suspension for spirited driving with improved cornering and stability.",
      itemName = "sport_suspension",
      price = 10000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 8,
      handling = {
        fSuspensionForce = 0.3,
        fSuspensionDamping = 0.15,
        fSuspensionCompDamp = 0.15,
        fSuspensionReboundDamp = 0.15,
        fAntiRollBarForce = 0.3,
        fTractionCurveLateral = 0.5
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [3] = {
      name = "Race Suspension",
      icon = "engine.svg",
      info = "Ultra-stiff suspension for maximum track performance with precise handling and cornering grip.",
      itemName = "race_suspension",
      price = 18000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 8,
      handling = {
        fSuspensionForce = 0.5,
        fSuspensionDamping = 0.25,
        fSuspensionCompDamp = 0.25,
        fSuspensionReboundDamp = 0.25,
        fAntiRollBarForce = 0.5,
        fTractionCurveLateral = 1.0,
        fInitialDriveForce = 0.02
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- WEIGHT REDUCTION
  -- Lightweight parts for better performance
  --
  weightReduction = {
    [1] = {
      name = "Lightweight Parts",
      icon = "engine.svg",
      info = "Replace heavy components with lightweight alternatives for better acceleration and handling.",
      itemName = "lightweight_parts",
      price = 12000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 9,
      handling = {
        fMass = -0.15,
        fInitialDriveMaxFlatVel = 0.03,
        fPetrolConsumptionRate = -0.04,
        vecCentreOfMassOffset = {x = 0.0, y = -0.05, z = -0.02},
        vecInertiaMultiplier = {x = 0.9, y = 0.9, z = 0.9}
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Carbon Fiber Body",
      icon = "engine.svg",
      info = "Extensive carbon fiber replacement for maximum weight reduction and performance gains.",
      itemName = "carbon_fiber_body",
      price = 28000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 9,
      handling = {
        fMass = -0.25,
        fInitialDriveMaxFlatVel = 0.05,
        fPetrolConsumptionRate = -0.06,
        vecCentreOfMassOffset = {x = 0.0, y = -0.08, z = -0.03},
        vecInertiaMultiplier = {x = 0.8, y = 0.8, z = 0.8}
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- AERODYNAMICS
  -- Aerodynamic modifications for better high-speed performance
  --
  aerodynamics = {
    [1] = {
      name = "Street Spoiler",
      icon = "engine.svg",
      info = "Subtle aerodynamic enhancement for improved stability at highway speeds.",
      itemName = "street_spoiler",
      price = 6000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 10,
      handling = {
        fDownforceModifier = 0.1,
        fInitialDragCoeff = -0.05,
        fInitialDriveMaxFlatVel = 0.02
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Race Wing",
      icon = "engine.svg",
      info = "High-downforce wing for maximum cornering grip and high-speed stability.",
      itemName = "race_wing",
      price = 12500,
      handlingOverwritesValues = false,
      handlingApplyOrder = 10,
      handling = {
        fDownforceModifier = 0.3,
        fInitialDragCoeff = -0.1,
        fInitialDriveMaxFlatVel = 0.05,
        fTractionCurveLateral = 0.5
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- TRANSMISSION TUNING
  -- Different transmission options for various driving preferences
  --
  transmissions = {
    [1] = {
      name = "8-Speed Automatic",
      icon = "engine.svg",
      info = "Smooth 8-speed automatic transmission for effortless performance with optimized gear ratios.",
      itemName = "8speed_auto",
      price = 13000,
      handlingOverwritesValues = true,
      handlingApplyOrder = 11,
      handling = {
        nInitialDriveGears = 8,
        fClutchChangeRateScaleUpShift = 5.5,
        fClutchChangeRateScaleDownShift = 5.5,
        fPetrolConsumptionRate = -0.03
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- DIFFERENTIAL TUNING
  -- Different differential setups for various driving styles
  --
  differentials = {
    [1] = {
      name = "Limited Slip Differential",
      icon = "engine.svg",
      info = "Balanced differential for daily driving with improved traction and fuel efficiency.",
      itemName = "lsd_differential",
      price = 8000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 12,
      handling = {
        fTractionBiasFront = 0.0,
        fTractionCurveLateral = 1.5,
        fTractionSpringDeltaMax = 0.05,
        fLowSpeedTractionLossMult = 0.8,
        fPetrolConsumptionRate = -0.03
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Race Differential",
      icon = "engine.svg",
      info = "High-performance differential optimized for track use with maximum cornering grip and power delivery.",
      itemName = "race_differential",
      price = 20000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 12,
      handling = {
        fTractionBiasFront = -0.15,
        fTractionCurveLateral = 3.5,
        fTractionSpringDeltaMax = 0.08,
        fLowSpeedTractionLossMult = 0.6,
        fInitialDriveForce = 0.04
      },
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- ECU TUNING
  -- Engine control unit modifications for power gains
  --
  ecuTuning = {
    [1] = {
      name = "Stage 1 ECU",
      icon = "engine.svg",
      info = "Mild ECU tune for improved power and throttle response with optimized fuel efficiency.",
      itemName = "stage1_ecu",
      price = 8500,
      handlingOverwritesValues = false,
      handlingApplyOrder = 13,
      handling = {
        fInitialDriveForce = 0.05,
        fInitialDriveMaxFlatVel = 0.03,
        fDriveInertia = 0.95,
        fPetrolConsumptionRate = -0.08
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Stage 2 ECU",
      icon = "engine.svg",
      info = "Aggressive ECU tune for maximum power gains with increased fuel consumption. Requires supporting modifications.",
      itemName = "stage2_ecu",
      price = 15000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 13,
      handling = {
        fInitialDriveForce = 0.12,
        fInitialDriveMaxFlatVel = 0.08,
        fDriveInertia = 0.9,
        fPetrolConsumptionRate = 0.15
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  },

  --
  -- COOLING SYSTEMS
  -- Improved cooling for better engine performance and reliability
  --
  cooling = {
    [1] = {
      name = "Performance Radiator",
      icon = "engine.svg",
      info = "High-flow radiator for improved engine cooling and reliability with performance gains.",
      itemName = "performance_radiator",
      price = 6000,
      handlingOverwritesValues = false,
      handlingApplyOrder = 14,
      handling = {
        fEngineDamageMult = -0.2,
        fInitialDriveForce = 0.03,
        fPetrolConsumptionRate = -0.05
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    },
    [2] = {
      name = "Race Intercooler",
      icon = "engine.svg",
      info = "High-performance intercooler for forced induction engines. Reduces heat soak and improves power.",
      itemName = "race_intercooler",
      price = 8500,
      handlingOverwritesValues = false,
      handlingApplyOrder = 14,
      handling = {
        fEngineDamageMult = -0.3,
        fInitialDriveForce = 0.02
      },
      restricted = "combustion",
      blacklist = {"vetirs", "linerunner", "brickades", "blacktop", "aerocab", "packer", "phantom2", "v8truck", "hauler2", "phantom"}
    }
  }

  --
  -- EXAMPLE CUSTOM NEW CATEGORY
  -- 
  -- ["Transmissions"] = {
  --   [1] = {
  --     name = "8 speed transmission",
  --     icon = "transmission.svg",
  --     info = "Testing making a new category",
  --     itemName = "transmission",
  --     price = 1000,
  --     handlingOverwritesValues = true,
  --     handling = {
  --       nInitialDriveGears = 8
  --     },
  --     restricted = false,
  --   }
  -- }
  --
  -- -- IMPORTANT NOTE --
  -- inside of the config.lua, inside of a mechanic location's "tuning" section, you will need to add an
  -- additional line in order for it to show & be enabled in the tablet 
  --
  -- ["Transmissions"] = { enabled = true, requiresItem = false },
}