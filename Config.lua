Config = {}
-- DISCORD : https://discord.gg/zcG9KQj3sa
-- STORE : https://store.devcore.cz/

Config.PlaceHookahs = {} -- DONT TOUCH

-- Framework is automatically detected here you have the option to replace the default exports with your own
Config.Export = function()
    if STATE.FRAMEWORK == 'ESX'  then -- ESX
-- insert your esx export here
    return exports['es_extended']:getSharedObject()
--
    elseif STATE.FRAMEWORK == 'QB'  then -- QB or QBX 
-- insert your qb or qbx export here
    return exports['qb-core']:GetCoreObject()
--
    end
end


Config.DefaultButtons = {
    ['PLACE'] = {
        ['PLACE'] = {key = 'G', label = 'PLACE'},
        ['HIDE'] = {key = 'X', label = 'HIDE'},

    },
    ['HANDLE'] = {
        ['SMOKE'] = {key = 'E', label = 'SMOKE'},
        ['DROP'] = {key = 'X', label = 'DROP HANDLE'}
    },
    ['STOVE'] = {
        ['PLACE'] = {key = 'G', label = 'PLACE'},
        ['HIDE'] = {key = 'X', label = 'HIDE'},
    },
    ['POT'] = {
        ['DROP'] = {key = 'X', label = 'DROP COALS'}
    },
}


-- NOTIFY FUNCTION --
Config.Notify = function(message, type)

        lib.notify({
            title = 'Hookah',
            description = message,
            type = type,
            position = 'top',
            duration = 3000,
        })

end

-- CUSTOM KEY INTERACTION --
Config.ShowKeyInteraction = function(keydata, menuid, settings)
        exports['devcore_keyinteraction']:ShowPermanentKeypressUI(menuid, keydata, {
            position = settings.position,
            hexColor = settings.hexColor,
            keyColor = settings.keyColor,
            shadowColor = settings.shadowColor,
            shadowIntensity = settings.shadowIntensity,
            shadowBlur = settings.shadowBlur,
            offsetX = settings.offsetX,
            offsetY = settings.offsetY
        })
end

Config.DisableKeyInteraction = function (menuid)
    exports['devcore_keyinteraction']:HideKeypressUI(menuid)
end

Config.KeyInteractionSettings = {
            ['MAIN'] = {
                position = 'right',
                hexColor = nil,
                keyColor = nil,
                shadowColor = nil,
                shadowIntensity = nil,
                shadowBlur = nil,
                offsetX = nil,
                offsetY = nil
            },
            ['STATUS'] = {
                position = 'right',
                hexColor = nil,
                keyColor = nil,
                shadowColor = nil,
                shadowIntensity = nil,
                shadowBlur = nil,
                offsetX = nil,
                offsetY = nil
            },
            ['CARRYING'] = {
                position = 'right',
                hexColor = nil,
                keyColor = nil,
                shadowColor = nil,
                shadowIntensity = nil,
                shadowBlur = nil,
                offsetX = nil,
                offsetY = nil
            }
}

-- STATUS --
Config.Status = { --Settings for adding Armor, remove Stress and High Effect
    ["ARMOR"] = function(value) -- Trigger to increase thirst status
        AddArmourToPed(PlayerPedId(), value)
    end,
    ["STRESS"] = function(value) -- Here you can insert an export or trigger for your stress system
        if STATE.FRAMEWORK == 'ESX' then

         TriggerEvent('esx_status:remove', 'stress', value) -- this trigger only works for the esx_status stress system

        elseif STATE.FRAMEWORK == 'QB' then -- Trigger for QB-Core / QBX

            TriggerServerEvent('hud:server:RelieveStress', value)

        end
    end,
    ["HUNGER"] = function(value) -- Here you can insert an export or trigger for your hunger system
            if STATE.FRAMEWORK == 'ESX' then -- Trigger for ESX

         TriggerEvent('esx_status:add', 'hunger', -value) -- this trigger only works for the esx_status system

        elseif STATE.FRAMEWORK == 'QB' then -- Trigger for QB-Core / QBX

           TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] - value)

        end
    end,
    ["THIRST"] = function(value)  -- Here you can insert an export or trigger for your thirst system
            if STATE.FRAMEWORK == 'ESX' then -- Trigger for ESX

            TriggerEvent('esx_status:add', 'thirst', -value) -- this trigger only works for the esx_status system

        elseif STATE.FRAMEWORK == 'QB' then -- Trigger for QB-Core / QBX

            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - value)
        end
    end,
}


Config.Settings = {
    PlaceDistance = 3.0, -- Distance for placing hookah
    Take = 'owner', -- 'all' = anyone can take hookahs and stoves, 'owner' = only the person who placed it can take it
    SmokingCooldown = 3000, -- Cooldown  (3 sec)
    RemoveHookahWater = 0.2, -- How much water is removed per puff
    SmokingAnimation = {anim = 'smokevape_c', dict = 'smoke_vape@devcore',  params = {1.0, -1.0, 2500, 49, 1}}, -- Animation when smoking hookah
    SmokingHold = {enable = false, anim = 'static', dict = 'amb@code_human_wander_drinking@male@base', params = {8.0, -8, -1, 49, 0} }, -- Animation when holding handle and pot
    InteractionAnim = {anim = 'a_uncuff', dict = 'mp_arresting', params = {8.0, -8, 2500, 49, 0}}, -- Animation when interacting with hookah and stove
    Particles = { -- Smoke Effect 
            particleName = 'exp_grd_bzgas_smoke',
            particleDict = 'core',
            Scale = 0.4, -- size of smoke after exhalation
            Offset = vector3(0.014, -0.003, 0.008),
            Rot = vector3(55.0, 0.0, 110.0),
    },
    TargetInteraction = { -- Hookah TargetInteraction
        ['take'] = {
            label = "Take hookah",
            icon = "fas fa-hand-paper",
            distance = 3.0
        },
        ['add_tobacco'] = {
            label = "Add tobacco",
            icon = "fas fa-leaf",
            distance = 2.0
        },
        ['connect_handle'] = {
            label = "Connect handle",
            icon = "fas fa-link",
            distance = 2.0
        },
        ['take_handle'] = {
            label = "Take handle",
            icon = "fas fa-hand-rock",
            distance = 2.0
        },
        ['drop_handle'] = {
            label = "Drop handle",
            icon = "fas fa-hand-paper",
            distance = 2.0
        },
        ['disconnect_handle'] = {
            label = "Disconnect handle",
            icon = "fas fa-unlink",
            distance = 2.0
        },
        ['add_coals'] = {
            label = "Add coals",
            icon = "fas fa-fire",
            distance = 2.0
        },
        ['take_coals'] = {
            label = "Take coals",
            icon = "fas fa-hand-paper",
            distance = 2.0
        },
        ['clean_burned_coals'] = {
            label = "Clean coals",
            icon = "fas fa-trash",
            distance = 2.0
        },
        ['clean_burned_tobacco'] = {
            label = "Clean burned tobacco",
            icon = "fas fa-broom",
            distance = 2.0
        },

        ['clean_tobacco'] = {
            label = "Clean tobacco",
            icon = "fas fa-leaf",
            distance = 2.0
        },
        ['add_water'] = {
            label = "Add water",
            icon = "fas fa-tint",
            distance = 2.0
        },
        ['open_crown'] = {
            label = "Open crown",
            icon = "fas fa-unlock",
            distance = 2.0
        },
        ['close_crown'] = {
            label = "Close crown",
            icon = "fas fa-lock",
            distance = 2.0
        },
    }
}

-- Coal stove system
Config.StoveSystem = {
    StoveProp = 'prop_devcore_hookah_stove', -- Stove prop
    PlaceDistance = 3.0, -- Distance for placing stove
    MaxCoalItems = 2, -- Maximum number of coal items in stove at once
    Temperature = {
        StartTemp = 0, -- Initial heater temperature
        MaxTemp = 800, -- Maximum heater temperature (800°C)
        HeatingRate = 2, -- Heating rate degrees per second
        CoolingRate = 5, -- Cooling rate degrees per second
        OptimalCoalTemp = 350, -- Optimal temperature for coals (reduced for faster achievement)
        IdealCoalTempMin = 50, -- Minimum ideal temperature
        CoalBurnTemp = 650, -- Temperature at which coals start to burn
        BurnTime = 60, -- Time after which coal burns at high temperature (60 seconds)
    },
    
    TargetInteraction = { -- Stove TargetInteraction
        ['select_coals'] = {
            label = "Select coals",
            icon = "fas fa-list",
            distance = 2.0
        },
        ['toggle_heating'] = {
            label = {on = 'Turn on', off = 'Turn off'},
            icon = "fas fa-power-off",
            distance = 2.0
        },
        ['take_coals'] = {
            label = "Take coals",
            icon = "fas fa-hand-paper",
            distance = 2.0
        },
        ['return_coals'] = {
            label = "Insert coals",
            icon = "fas fa-undo",
            distance = 2.0
        },
        ['clean_burned_coals'] = {
            label = "Clean coals",
            icon = "fas fa-trash",
            distance = 2.0
        },
        ['take_stove'] = {
            label = "Take stove",
            icon = "fas fa-hand-paper",
            distance = 2.0
        }
    }
}


-- Handle system for hookahs
Config.HandleSystem = {
    HandleProp = 'prop_devcore_hookah_handle', -- Handle prop in player's hand
    SmokeDistance = 2.0, -- Maximum distance for smoking with handle
    MaxDistance = 3.5, -- Maximum distance before handle is automatically dropped
    RopeOffset = {
        hookah = { forward = 0.0, right = 0.0, up = -0.10 }, -- Offset for connection to hookah
        handle = { forward = 0.0, right = 0.0, up = -0.112 }  -- Offset for connection to handle
    },
    RopeLength = 2.0, -- Rope length (increased for better functionality)
    RopeType = 1, -- Rope type (1 = standard)
}


Config.HookahWaterItems = { -- items for filling hookah with water
    'water',
    'water_bottle',
}

Config.HookahAccessoriesItems = {
    Pot = {
        label = 'Coal pot',
        neededItem = 'hookah_pot', -- Item needed to transfer coal to a hookah
        prop = 'v_res_tt_pot02',
        position = {
                BoneID = 64097,
                Offset = vector3(0.020, -0.08, 0.008),
                Rot = vector3(10.0, 0.0, 100.0),
        }
    },
    Stove = {
        label = 'Coal stove',
        neededItem = 'hookah_stove', -- Item needed to heat the coals in a hookah
        prop = 'prop_devcore_hookah_stove', 
        position = {
                BoneID = 57005,
                Offset = vector3(0.176000, 0.048000, 0.0),
                Rot = vector3(-89.550529, 0.000000, -2.250000),
        }
    },
    Handle = {
        label = 'Hookah handle',
        neededItem = 'hookah_handle', -- Item required to connect the rope 
        prop = 'prop_devcore_hookah_handle',
        position = {
                BoneID = 57005,
                Offset = vector3(0.112000, 0.022000, 0.0),
                Rot = vector3(-69.900330, 0.0, -26.099960),
        }
    },
}

Config.HookahCoalItems = {
    ['hookah_wooden_coals'] = { -- Item name for coal
        label = 'Wooden Coals',
        health = 100,
        damage_per_second = 0.3, -- How much health coal loses per second when burning
    },
    ['hookah_coconut_coals'] = {  -- Item name for coal
        label = 'Coconut Coals',
        health = 100,
        damage_per_second = 0.2, -- How much health coal loses per second when burning
    },
    ['hookah_bamboo_coals'] = {  -- Item name for coal
        label = 'Bamboo Coals',
        health = 100,
        damage_per_second = 0.1, -- How much health coal loses per second when burning
    },
}

Config.HookahTobaccoItems = {
    ['hookah_blueberry_tobacco'] = {  -- Item name for tobacco
        label = 'Blueberry Tobacco',
        health = 100,
        damage_per_second = 0.4, -- How much health tobacco loses per second when burning
        exhaleEffect = {
            enable = true, -- false for disable
            blackoutIntensity = 60, -- false for disable
            vibrationCam = false, -- false for disable
            vibrationValue = 0.0,
        },
        status = {
            ['ARMOR'] = 1, -- Adds armor after each puff of smoke
            ['STRESS'] = 5, -- Removes stress after smoke exhalation
            ['HUNGER'] = 20000, -- Removes Hunger after smoke exhalation
            ['THIRST'] = 20000, -- Removes Thirst after smoke exhalation
        },
    },
    ['hookah_raspberry_tobacco'] = { -- Item name for tobacco
        label = 'Raspberry Tobacco',
        health = 100,
        damage_per_second = 0.3, -- How much health tobacco loses per second when burning
        exhaleEffect = {
            enable = true, -- false for disable
            blackoutIntensity = 60, -- false for disable
            vibrationCam = true, -- false for disable
            vibrationValue = 1.0,
        },
        status = {
            ['ARMOR'] = 1, -- Adds armor after each puff of smoke
            ['STRESS'] = 5, -- Removes stress after smoke exhalation
            ['HUNGER'] = 20000, -- Removes Hunger after smoke exhalation
            ['THIRST'] = 20000, -- Removes Thirst after smoke exhalation
        },
    },
    ['hookah_blackberry_tobacco'] = { -- Item name for tobacco
        label = 'Blackberry Tobacco',
        health = 100,
        damage_per_second = 0.2, -- How much health tobacco loses per second when burning
        exhaleEffect = {
            enable = true, -- false for disable
            blackoutIntensity = 60, -- false for disable
            vibrationCam = true, -- false for disable
            vibrationValue = 1.8,
        },
        status = {
            ['ARMOR'] = 1, -- Adds armor after each puff of smoke
            ['STRESS'] = 5, -- Removes stress after smoke exhalation
            ['HUNGER'] = 20000, -- Removes Hunger after smoke exhalation
            ['THIRST'] = 20000, -- Removes Thirst after smoke exhalation
        },
    },
    ['hookah_cherry_tobacco'] = { -- Item name for tobacco
        label = 'Cherry Tobacco',
        health = 100, 
        damage_per_second = 0.1, -- How much health tobacco loses per second when burning
        exhaleEffect = {
            enable = true, -- false for disable
            blackoutIntensity = 60, -- false for disable
            vibrationCam = true, -- false for disable
            vibrationValue = 1.3, 
        },
        status = {
            ['ARMOR'] = 1, -- Adds armor after each puff of smoke
            ['STRESS'] = 5, -- Removes stress after smoke exhalation
            ['HUNGER'] = 20000, -- Removes Hunger after smoke exhalation
            ['THIRST'] = 20000, -- Removes Thirst after smoke exhalation
        },
    },
}

Config.HookahItems = { 
    ['classic_hookah'] = { -- Item name for hookah
        Settings = { 
            Label = 'Hookah',
            MaxSmokers = 4,
        },
        PropsPositionsInHand = {
                BoneID = 57005,
                Offset = vector3(0.118000, 0.121000, 0.000000),
                Rot = vector3(-75.900391, 0.000000, -0.900000),
        },

        Props = {
            ['open_clean'] = 'prop_devcore_hookah_a_open_clean',
            ['open_ignited'] = 'prop_devcore_hookah_a_open_ignited',
            ['open_no_ignited'] = 'prop_devcore_hookah_a_open_no_ignited',
            ['close'] = 'prop_devcore_hookah_a_close',
        },
        -- Default state for new hookahs
        DefaultState = {
            coals = {}, -- Array of coal objects {item = 'coal_name', health = 100, lit = false, timestamp = 0}
            tobacco = {}, -- Array of tobacco objects {item = 'tobacco_name', health = 100, timestamp = 0}
            accessories = {}, -- Array of accessories {item = 'accessory_name', attached = true}
            handles = {}, -- Array of connected handles {playerId = 0, handleObj = nil, pipeObj = nil}
            water = 0, -- Water level percentage
            status = 'clean', -- clean, dirty, needs_cleaning
            crownOpen = false, -- Crown state - false = closed, true = open
        }
    }
}



Config.Translations = {
    ['TEXT'] = {

        -- Success messages
        ['hookah_placed_successfully'] = 'Hookah was successfully placed',
        ['tobacco_added_successfully'] = 'Added %s to hookah successfully!',
        ['coals_added_successfully'] = 'Added heated coals to hookah!',
        ['water_added_successfully'] = 'Added water to hookah using %s',
        ['handle_connected_successfully'] = 'Connected handle to hookah successfully!',
        ['handle_taken_successfully'] = 'You took the handle from hookah',
        ['handle_dropped_successfully'] = 'You put down the handle',
        ['handle_disconnected_successfully'] = 'Handle disconnected from hookah successfully!',
        ['coals_taken_from_hookah'] = 'You took coal from hookah into pot!',
        ['smoked_with_handle'] = 'You smoked from hookah using handle!',
        ['stove_placed_successfully'] = 'Stove placed successfully!',
        ['coals_placed_on_stove'] = 'Placed %s on stove!',
        ['coals_taken_from_stove'] = 'Took %d heated coal into pot!',
        ['coals_returned_to_stove'] = 'Returned %d coals from pot to stove!',
        ['coals_dropped'] = 'You dropped coals from pot!',
        ['crown_opened'] = 'Hookah crown opened!',
        ['crown_closed'] = 'Hookah crown closed!',
        
        -- Cleaning messages
        ['burned_coals_cleaned'] = 'You cleaned %d burned %s from hookah!',
        ['burned_coals_cleaned_stove'] = 'You cleaned %d burned coals from stove (%d from coals, %d from heated coals)',
        ['burned_tobacco_cleaned'] = 'You cleaned %d burned %s from hookah!',
        ['all_tobacco_cleaned'] = 'You cleaned %d %s from hookah!',
        
        -- Error messages
        ['no_item_in_inventory'] = 'You don\'t have %s in inventory!',
        ['hookah_not_found'] = 'Hookah not found!',
        ['stove_not_found'] = 'Stove not found!',
        ['no_tobacco_in_hookah'] = 'There is no tobacco in hookah!',
        ['no_burned_tobacco'] = 'There is no burned tobacco in hookah!',
        ['no_coals_in_hookah'] = 'There are no coals in hookah!',
        ['no_burned_coals'] = 'There are no burned coals in hookah!',
        ['no_coals_in_stove'] = 'There are no coals in stove!',
        ['no_usable_coals'] = 'There are no usable coals in hookah!',
        ['hookah_full_coals'] = 'Hookah already has maximum number of coals!',
        ['stove_full_coals'] = 'Stove already has maximum number of coals!',
        ['already_carrying_coals'] = 'You are already carrying coals!',
        ['not_carrying_coals'] = 'You don\'t have any coals in pot!',
        ['handle_limit_reached'] = 'Maximum number of handles reached!',
        ['no_available_handles'] = 'No available handles! All connected handles are being used by other players.',
        ['not_holding_handle'] = 'You are not holding any handle!',
        ['crown_must_be_open'] = 'Crown must be open to clean tobacco!',
        ['cannot_clean_with_coals'] = 'Cannot clean tobacco while there are coals in hookah!',
        ['cannot_take_hookah'] = 'Cannot take hookah - %s',
        ['cannot_take_stove'] = 'Cannot take stove - it must be turned off, empty and cool!',
        ['only_owner_can_take'] = 'You can only take items that you placed!',
        ['hookah_has_hot_coals'] = 'The hookah still has hot coals!',
        ['hookah_has_fresh_tobacco'] = 'The hookah still has fresh tobacco!',
        ['players_holding_handles'] = 'Players are holding handles! They must drop them first.',
        ['hookah_can_be_taken'] = 'Hookah can be taken',
        ['stove_is_active'] = 'The stove is active or contains coals!',
        ['stove_can_be_taken'] = 'Stove can be taken',
        ['item_not_found'] = 'Item was not found',
        ['hookah_taken_success'] = '%s was successfully taken',
        ['stove_name'] = 'Stove',
        ['hookah_name'] = 'Hookah',

        
        -- Status texts
        ['stove_on'] = 'turned on',
        ['stove_off'] = 'turned off',
        ['coal_singular'] = 'coal',
        ['coal_2to4'] = 'coals', 
        ['coal_plural'] = 'coals',
        ['tobacco_singular'] = 'tobacco',
        ['tobacco_2to4'] = 'tobaccos',
        ['tobacco_plural'] = 'tobaccos',
        
        -- UI texts
        ['no_coals_in_stove_ui'] = 'No coals in stove',
        ['heating_coals'] = '🔥 Heating coals (%d):',
        ['ready_coals'] = '✅ Ready coals (%d):',
        ['burned_coals'] = '💀 Burned coals (%d):',
        ['stove_temperature'] = 'Stoves temperature:',
        ['coal_temperature'] = 'Temperature:',
        ['coal_health'] = 'Health:',
        ['coal_burning'] = '🔥 BURNING!',
        ['coal_burned'] = '💀 BURNED',
        ['coal_ready'] = '✅ READY',
        ['coal_heating'] = '🔥 HEATING',
        ['hookah_dirty'] = '🧹 Needs cleaning',
        ['hookah_no_water'] = '💧 Needs water',
        ['hookah_no_coals'] = '🔥 Needs coals',
        ['hookah_no_tobacco'] = '🍃 Needs tobacco',
        ['water_label'] = '💧 Water:',
        ['coals_label'] = '🔥 Coals:',
        ['tobacco_label'] = '🍃 Tobacco:',
        ['handles_label'] = '🎯 Handles:',
        ['handles_connected'] = 'connected',
        ['no_coals_status'] = 'none',
        ['no_tobacco_status'] = 'none',
        ['unknown_coal_label'] = 'Unknown coal',
        ['unknown_tobacco_label'] = 'Unknown tobacco',
        ['coal_hot_status'] = '🔥 Hot',
        ['coal_warm_status'] = '🔥 Warm',
        ['coal_cold_status'] = '❄️ Cold',
        ['coal_ideal_temp_status'] = '✅ Ready',
        ['coal_number'] = 'Coal #%d',
        ['heated_coal_number'] = 'Heated coal #%d',
        ['burned_coal_number'] = 'Burned coal #%d',
        ['hookah_unknown_status'] = '❓ Unknown state',
        ['coal_cooled_status'] = '❄️ Cooled',
        ['tobacco_exhausted_status'] = '💀 Exhausted',
        ['tobacco_burned'] = '💀 Burned',

        -- Client-side messages
        ['hookah_not_found_client'] = 'Hookah not found!',
        ['too_far_from_hookah'] = 'You are too far from hookah!',
        ['carrying_coals_message'] = 'You are carrying heated coals in pot! Find hookah and add them using target.',
        ['cannot_place_stove_carrying'] = 'You cannot place stove while carrying something!',
        ['too_far_away'] = 'You are too far away!',
        ['translations_refreshed'] = 'Translations refreshed! Check console for details.',
        ['no_coals_in_pot'] = 'You don\'t have any coals in pot!',
        ['count'] = 'Count: ',
        
        -- Tobacco menu
        ['tobacco_menu_title'] = 'Tobacco Selection',
        ['no_tobacco_title'] = 'No tobacco',
        ['no_tobacco_description'] = 'You don\'t have any tobacco in inventory',
        ['tobacco_available'] = 'Available:',
        
        -- Coal menu
        ['coal_menu_title'] = 'Coal Selection for Stove',
        ['no_coals_title'] = 'No coals',
        ['no_coals_description'] = 'You don\'t have any coals in inventory',
        
        -- Server-side notification messages
        ['stove_max_coals_error'] = 'Stove already has maximum coals!',
        ['stove_not_found_error'] = 'Stove not found!',
        ['no_ready_coals_in_stove'] = 'There are no ready coals in stove!',
        ['need_pot_for_coals'] = 'You need a pot to take hot coals!',
        ['no_coals_in_pot_to_return'] = 'You don\'t have any coals in pot to return!',
        ['stove_not_found_return'] = 'Stove not found!',
        ['stove_max_coals_return'] = 'Stove already has maximum coals! (Max: %d)',
        ['coals_returned_to_stove_success'] = 'You returned %d coals from pot to stove!',
        ['hookah_already_has_coals'] = 'Hookah already has coals! You can only add one coal item.',
        ['all_coals_burned_in_pot'] = 'All coals in pot are burned! You cannot add them to hookah.',
        ['coal_added_to_hookah_remaining'] = 'You added 1 coal to hookah! You have %d coals remaining in pot.',
        ['last_coal_added_to_hookah'] = 'You added the last coal to hookah!',
        ['no_coals_in_hookah_clean'] = 'There are no coals in hookah!',
        ['no_burned_coals_hookah'] = 'There are no burned coals in hookah!',
        ['coals_cleaned_from_hookah'] = 'You cleaned %d burned %s from hookah!',
        ['no_tobacco_in_hookah_clean'] = 'There is no tobacco in hookah!',
        ['no_burned_coals_stove'] = 'There are no burned coals in stove!',
        ['coals_cleaned_from_stove'] = 'You cleaned %d burned coals from stove!',
        ['coals_cleaned_from_stove_detailed'] = 'You cleaned %d burned coals from stove (%d from coals, %d from heated coals)',
        ['selected_coal_burned'] = 'Selected coal is burned! You cannot take it in pot.',
        ['no_usable_coals_hookah'] = 'There are no usable coals in hookah! Burned coals can only be cleaned.',
        ['hookah_water_full'] = 'Hookah already has full water tank!',
        ['no_water_item'] = 'You don\'t have any water item to refill hookah!',
        ['water_added_to_hookah'] = 'You added water to hookah! Tank is now full.',
        ['crown_opened_success'] = 'You opened hookah crown!',
        ['crown_closed_success'] = 'You closed hookah crown!',
        ['hookah_already_has_tobacco'] = 'Hookah already has tobacco! You can only add one tobacco item.',
        ['no_hookah_handle'] = 'You don\'t have a hookah handle!',
        ['max_handles_connected'] = 'Maximum number of handles connected to hookah (%d)!',
        ['no_available_handle'] = 'No available handle to take!',
        ['not_holding_handle_server'] = 'You are not holding any handle!',
        ['no_handle_connected'] = 'You don\'t have a handle connected to this hookah!',
        ['smoking_cooldown_wait'] = 'You need to wait %d more seconds before smoking again!',
        ['must_hold_handle'] = 'You must be holding the handle to smoke!',
        ['coals_not_hot_enough'] = 'Coals in hookah are not hot enough! (min. %d°C)',
        ['no_stove_item'] = 'You don\'t have a stove!',
        ['stove_placed_success'] = 'Stove was placed!',
        ['stove_not_found_server'] = 'Stove was not found!',
        ['no_coal_type'] = 'You don\'t have this type of coals!',
        ['coal_heating_info'] = 'Coals for hookah',
        ['smoking_cooldown'] = 'You need to wait before smoking again!',
        ['hookah_needs_tobacco'] = 'Hookah needs tobacco to smoke!',
        ['hookah_needs_water'] = 'Hookah needs water to smoke!',
        ['stove_heating_turned'] = 'Stove was %s!', -- %s will be "turned on" or "turned off"

    },

}
