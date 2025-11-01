--- QBCORE Crypto ----

CallBackRegisterServer('gksphone:server:getWalletID', function(source, cb, data)
	local src = source
	local PlayerSource = GetSourceByNumber(data.Number)
	local phoneLang = GetPhoneLangBySource(source)
	if not PlayerSource then
		local notify = {
			title = _T(phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
			message = _T(phoneLang, "QbitAPP.APP_QBIT_NOPERSON"), -- The message of the notification
			icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
			duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
		}
		exports["gksphone"]:sendNotification(source, notify)
		cb(false)
		return
	end
	local Player = Config.Core.Functions.GetPlayer(PlayerSource)
	if Player then
		local WalletID = Player.PlayerData.metadata["walletid"]
		cb(WalletID)
	else
		local notify = {
			title = _T(phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
			message = _T(phoneLang, "QbitAPP.APP_QBIT_NOTIFY_TRANSFERSUCESS"), -- The message of the notification
			icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
			duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
		}
		exports["gksphone"]:sendNotification(source, notify)
		cb(false)
	end
end)

CreateThread(function()
	if Config.Framework == "qb" and GetResourceState("qb-crypto") == 'started' then
		Wait(5000)
		local appData = {
			name = "qbit",
			icons = "/html/img/icons/qbit.png",
			description = "qbit",
			url = "/qbit",
			blockedjobs = {},
			allowjob = {},
			signal = true,
			show = Config.Qbit,
			labelLangs = {
				af = "Qbit",
				ar = "Qbit",
				cs = "Qbit",
				de = "Qbit",
				en = "Qbit",
				es = "Qbit",
				fr = "Qbit",
				id = "Qbit",
				nl = "Qbit",
				["pt-PT"] = "Qbit",
				ro = "Qbit",
				sv = "Qbit",
				th = "Qbit",
				tr = "Qbit",
				uk = "Qbit",
				["zh-TW"] = "Qbit"
			}
		}
		exports["gksphone"]:AddCustomApp(appData)
	end
end)