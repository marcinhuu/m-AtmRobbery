local QBCore = exports[Config.Settings.Core]:GetCoreObject()
local cooldown = false

RegisterNetEvent('m-AtmRobbery:Server:ToggleItem', function(type, item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then end
    if type == "add" then
        Player.Functions.AddItem(item, amount)
    elseif type == "remove" then
        Player.Functions.RemoveItem(item, amount)
    end
end)

RegisterServerEvent('m-AtmRobbery:Server:StartCooldown', function()
    cooldown = true
    local timer = Config.Settings.CoolDown * (60 * 1000)
    while timer > 0 do Wait(1000) timer = timer - 1000 if timer == 0 then cooldown = false end end
end)

QBCore.Functions.CreateCallback('m-AtmRobbery:Server:CoutPolice', function(source, cb)
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        for a, b in pairs(Config.Settings.JobPolice) do
            if v.PlayerData.job.name == b and v.PlayerData.job.onduty then amount = amount + 1 end
        end
    end
    if amount >= Config.Settings.AmountPolice then cb(true) else cb(false) end
end)

QBCore.Functions.CreateCallback("m-AtmRobbery:Server:Cooldown",function(source, cb)
    if cooldown then cb(true) else cb(false) end
end)


RegisterServerEvent('m-AtmRobbery:Server:RewardAtmRobbery', function()
    local src = source
	local Player =  QBCore.Functions.GetPlayer(source)
    if not Player then end
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    if Config.Settings.Rewards.Type == "cash" then
        local amount = math.random(Config.Settings.Rewards.Cash.min, Config.Settings.Rewards.Cash.max)
        Player.Functions.AddMoney("cash", amount)
        AtmRobberyLog( "**🧍‍♂️ [Player Information]** " .. "\n" ..  "**Player Name:** "..Player.PlayerData.name.. "\n" ..  "**CitizenID:** "..Player.PlayerData.citizenid.. "\n" ..  "**Location:** "..playerCoords.. "\n" ..  "\n" .. "\n".. "**💸 [Steal-ATM]** " .. "\n" ..  "**CASH EARN:** "..amount.."$" )
    elseif Config.Settings.Rewards.Type == "blackmoney" then
        local bags = Config.Settings.Rewards.Blackmoney.Bags
        local item = Config.Settings.Rewards.Blackmoney.Item
    	local info = { worth = math.random(Config.Settings.Rewards.Blackmoney.Worth.min, Config.Settings.Rewards.Blackmoney.Worth.max)}
    	Player.Functions.AddItem(item, bags, false, info)
        AtmRobberyLog( "**🧍‍♂️ [Player Information]** " .. "\n" ..  "**Player Name:** "..Player.PlayerData.name.. "\n" ..  "**CitizenID:** "..Player.PlayerData.citizenid.. "\n" ..  "**Location:** "..playerCoords.. "\n" ..  "\n" .. "\n".. "**💸 [Steal-ATM]** " .. "\n" ..  "**BAGS:" .. bags .. "\n" .."**CASH EARN:** "..info.."$" )
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
    end
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print("^4m-AtmRobbery ^0|^2 Script started successfully.^7")
    print("^4m-AtmRobbery ^0|^5 Version: 1.1.0^7")
    print("^4m-AtmRobbery ^0|^2 If you need any help contact:^7")
    print("^4m-AtmRobbery ^0|^5 discord.gg/marcinhu^7")
    print("^4m-AtmRobbery ^0|^2 Thank you for being our customer^7") 
end)

-- ██╗░░░░░░█████╗░░██████╗░░██████╗
-- ██║░░░░░██╔══██╗██╔════╝░██╔════╝
-- ██║░░░░░██║░░██║██║░░██╗░╚█████╗░
-- ██║░░░░░██║░░██║██║░░╚██╗░╚═══██╗
-- ███████╗╚█████╔╝╚██████╔╝██████╔╝
-- ╚══════╝░╚════╝░░╚═════╝░╚═════╝░

function AtmRobberyLog(message)
    local embed = {}
    embed = {
        {
            ["color"] = 65280, -- GREEN = 65280 --- RED = 16711680
            ["title"] = "m-AtmRobbery | Logs",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
                ["icon_url"] = "https://media.discordapp.net/attachments/1049749773185470537/1049749885043351662/transparent-logo.png",
                ["text"] = 'Created By m-Scripts | https://marcinhu.tebex.io/ ',
            },
        }
    }
    PerformHttpRequest(Config.Settings.Webhook, 
    function(err, text, headers) end, 'POST', json.encode({username = 'm-AtmRobbery - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end