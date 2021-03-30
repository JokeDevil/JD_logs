Config = {}

Config.communtiyName = "Community Name Here"					-- Icon top of the Embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the Embed

Config.secretKey = ""						-- Secret key linked to your server. (use /newkey in discord to get a key.)

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.weaponLog = true  										-- set to false to disable the shooting weapon logs

Config.playerID = true											-- set to false to disable Player ID in the logs
Config.steamID = true											-- set to false to disable Steam ID in the logs
Config.steamURL = true											-- set to false to disable Steam URL in the logs
Config.discordID = true											-- set to false to disable Discord ID in the logs
Config.license = true											-- set to false to disable license in the logs
Config.IP = true												-- set to false to disable IP in the logs

Config.joinColor = "#3AF241" 	 								-- Player Connecting
Config.leaveColor = "#F23A3A"									-- Player Disconnected
Config.chatColor = "#A1A1A1"									-- Chat Message
Config.shootingColor = "#2E66F2"								-- Shooting a weapon
Config.deathColor = "#000000"									-- Player Died
Config.resourceColor = "#EBEE3F"								-- Resource Stopped/Started



Config.channels = { -- Use channel id's not webhooks.
	all = "",
	chat = "",
	joins = "",
	leaving = "",
	deaths = "",
	shooting = "",
	resources = "",
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "BETA_0.0.1"
