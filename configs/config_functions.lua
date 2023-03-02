local QBCore = exports[Config.Settings.Core]:GetCoreObject()

function AlertCops()
    if Config.Settings.Dispatch == 'ps-dispatch' then
        exports["ps-dispatch"]:CustomAlert({
            coords = GetEntityCoords(PlayerPedId()),
            message = "ATM Robbery",
            dispatchCode = "10-31",
            description = "Robbery",
            radius = 0,
            sprite = 108,
            color = 1,
            scale = 0.7,
            length = 3,
        })
    elseif Config.Settings.Dispatch == 'cd_dispatch' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'}, 
            coords = data.coords,
            title = '10-12 - ATM Robbery',
            message = 'A '..data.sex..' robbing a ATM at '..data.street, 
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = { sprite = 108,  scale = 0.7,  colour = 1, flashes = false,  text = 'ATM Robbery', time = (3*60*1000), sound = 1, }
        })
    end
end

function Fingerprint()
    local plyCoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
end

function Notify(msg, type, time)
    if Config.Settings.Notify == "QBCore" then
        if type == "primary" then  
            QBCore.Functions.Notify(msg, "primary", time) 
        end
        if type == "success" then
            QBCore.Functions.Notify(msg, "success", time)
        end
        if type == "error" then
            QBCore.Functions.Notify(msg, "error", time)
        end
    elseif Config.Settings.Notify == "okok" then
        if type == "primary" then 
            exports['okokNotify']:Alert('Beach Activities', msg, time, 'primary')
        end
        if type == "success" then
            exports['okokNotify']:Alert('Beach Activities', msg, time, 'success')
        end
        if type == "error" then
            exports['okokNotify']:Alert('Beach Activities', msg, time, 'error')
        end
    elseif Config.Settings.Notify == "mythic" then
        if type == "primary" then 
            exports['mythic_notify']:DoHudText('inform', msg)
        end
        if type == "success" then
            exports['mythic_notify']:DoHudText('success', msg)
        end
        if type == "error" then
            exports['mythic_notify']:DoHudText('error', msg)
        end
    end
end