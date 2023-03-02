local QBCore = exports[Config.Settings.Core]:GetCoreObject()

RegisterNetEvent('m-AtmRobbery:Client:StartRobAtm', function()
    QBCore.Functions.TriggerCallback("m-AtmRobbery:Server:CoutPolice", function(cb)
        if cb then
            QBCore.Functions.TriggerCallback("m-AtmRobbery:Server:Cooldown",function(isCooldown)
                if not isCooldown then
                    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
                    TriggerServerEvent('m-AtmRobbery:Server:ToggleItem', "remove", Config.Settings.HackItem, 1)
                    QBCore.Functions.Progressbar('HackingAtm', Config.Language["Hack"], Config.Settings.HackingTime * 1000, false, true, {
                        disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true,
                    }, {}, {}, {}, function()
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                        exports['ps-ui']:Circle(function(success)
                            if success then
                                ClearPedTasksImmediately(PlayerPedId())
                                Notify(Config.Language["Success"], "success", 5000)
                                ClearPedTasksImmediately(PlayerPedId())
                                AlertCops()
                                QBCore.Functions.Progressbar("GrabMoney", Config.Language["GrabMoney"], Config.Settings.GrabTime * 1000, false, true, {
                                    disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true,
                                }, {
                                    animDict = "anim@heists@ornate_bank@grab_cash_heels", anim = "grab", flags = 16,
                                }, {
                                   model = "prop_cs_heist_bag_02", bone = 57005, coords = { x = -0.005, y = 0.00, z = -0.16 }, rotation = { x = 250.0, y = -30.0, z = 0.0 },
                                }, {}, function()
                                    if Config.Settings.Fingerprint then Fingerprint() end
                                    TriggerServerEvent('m-AtmRobbery:Server:StartCooldown') -- Event to start the cooldown
                                    TriggerServerEvent("m-AtmRobbery:Server:RewardAtmRobbery") -- Event to receive the rewards
                                    StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
                                    SetPedComponentVariation((PlayerPedId()), 5, 47, 0, 0)
                                end, function()
                                    StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
                                end)
                            else
                                ClearPedTasksImmediately(PlayerPedId())
                                Notify(Config.Language["Failed"], 'error', 5000)
                                TriggerServerEvent('m-AtmRobbery:Server:ToggleItem', "add", Config.Settings.HackItem, 1)
                                AlertCops()
                            end
                        end, Config.Settings.PSui.NumberOfCircles, Config.Settings.PSui.MS)
                    end)
                else
                    Notify(Config.Language["Cooldown"], "error", 5000)
                end
            end)
        else
            Notify(Config.Language["Police"], "error", 5000)
        end
    end)
end)