local QBCore = exports[Config.Settings.Core]:GetCoreObject()

CreateThread(function()
    local models = { 'prop_atm_01', 'prop_atm_02', 'prop_atm_03', 'prop_fleeca_atm' }

    exports[Config.Settings.Target]:AddTargetModel(models, {
        options = {
            {
                event = "m-AtmRobbery:Client:StartRobAtm",
                icon = 'fa-solid fa-money-bill',
                label = 'Rob ATM',
                item = Config.Settings.HackItem,
            }
        },
      distance = 2.5,
    })
end)
