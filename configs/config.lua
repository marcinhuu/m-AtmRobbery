Config = {}

Config.Settings = {
	Core = "qb-core", -- Your core name folder
	Target = "qb-target", -- Your target name folder
	Dispatch = "ps-dispatch", -- "ps-dispatch" or "cd_dispatch"
	Notify = "QBCore", -- Change your notify here "QBCore" | "okok" | "mythic"
	Webhook = "", -- Webhook
	HackItem = "thermite", -- Item needed to hack the ATM
	Fingerprint = true, -- Enable fingerprints?
	HackingTime = 10, -- Time of progressbar when you stealing the ATM | 10 = 10 Seconds
	GrabTime = 10, -- Time of progressbar when you grabbing the money after hacking
	CoolDown = 10, -- How much cooldown? | 10 = 10 Minutes
	JobPolice = { "police", "lspd", }, -- Name of job police
	AmountPolice = 0, -- Amount of police needed
	PSui = { NumberOfCircles = 2, MS = 20 }, -- PS-UI Minigame Settings
	Rewards = {
		Type = "cash", -- "cash" or "blackmoney"
		Cash = {
			min = 3500, -- Min amount receive in cash
			max = 7500, -- Max amount receive in cash
		},
		Blackmoney = {
			Bags = 1, -- Amout of bags receive
			Item = "markedbills", -- Item name of blackmoney
			Worth = {
				min = 2500, -- Min amount receive each bag
				max = 3500, -- Max amount receive each bag
			},
		}
	}
}

Config.Language = {
	["Success"] = "Success!! Grab the money!",
	["Failed"] = "Seems Like you failed...",
	["GrabMoney"] = "Grabbing money...",
	["Hack"] = "Hacking the ATM...",
	["Cooldown"] = "You can't do that right now",
	["Police"] = "Not enough police"
}