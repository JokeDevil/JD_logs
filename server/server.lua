function sanitize(string)
    return string:gsub('%@', '')
end

exports('sanitize', function(string)
    sanitize(string)
end)

RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs", function(message, color, channel)
    discordLog(message, color, channel)
end)

-- Get exports from server side
exports('discord', function(message, id, id2, color, channel)

	if id ~= 0 then
		if id2 ~= 0 then
			local field1 = GetPlayerDetails(id)
			local field2 = GetPlayerDetails(id2)
			DualPlayerLogs(message, color, channel, field1, field2)
		else
			local field1 = GetPlayerDetails(id)
			SinglePlayerLogs(message, color, channel, field1)
		end
	else
		HidePlayerDetails(message, color, channel)
	end

end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

-- Sending message to the All Logs channel and to the channel it has listed
function HidePlayerDetails(message, color, channel)
  	if tonumber(Config.AllLogs) then
		if Config.channels["all"] then
			PerformHttpRequest('http://jd-logs.com/api', function(err, text, headers) end, 'POST', json.encode({
				["key"] = Config.secretKey,
				["id"] = Config.channels["all"],
				["author"] = {
					["name"] = Config.communtiyName,
					["icon"] = Config.communtiyLogo
				},
				["title"] = firstToUpper(channel),
				["message"] = message,
				["color"] = color
			}), { ['Content-Type'] = 'application/json' })
		end
  	end
	if tonumber(Config.channels[channel]) then
	PerformHttpRequest('http://jd-logs.com/api', function(err, text, headers) end, 'POST', json.encode({
			["key"] = Config.secretKey,
			["id"] = Config.channels[channel],
			["author"] = {
				["name"] = Config.communtiyName,
				["icon"] = Config.communtiyLogo
			},
			["title"] = firstToUpper(channel),
			["message"] = message,
			["color"] = color
		}), { ['Content-Type'] = 'application/json' })
	end
end

function SinglePlayerLogs(message, color, channel, field1)
	local _field1 = field1
	if Config.AllLogs then
		if tonumber(Config.channels["all"]) then
			PerformHttpRequest('http://jd-logs.com/api', function(err, text, headers) end, 'POST', json.encode({
				["key"] = Config.secretKey,
				["id"] = Config.channels["all"],
				["author"] = {
					["name"] = Config.communtiyName,
					["icon"] = Config.communtiyLogo
				},
				["title"] = firstToUpper(channel),
				["message"] = message,
				["color"] = color,
				["field1"] = {
					["title"] = "Player 1",
					["message"] = _field1,
					["inline"] = "true"
				}
			}), { ['Content-Type'] = 'application/json' })
		end
  	end
	if tonumber(Config.channels[channel]) then
	PerformHttpRequest('http://jd-logs.com/api', function(err, text, headers) end, 'POST', json.encode({
			["key"] = Config.secretKey,
			["id"] = Config.channels[channel],
			["author"] = {
				["name"] = Config.communtiyName,
				["icon"] = Config.communtiyLogo
			},
			["title"] = firstToUpper(channel),
			["message"] = message,
			["color"] = color,
			["field1"] = {
				["title"] = "Player 1",
				["message"] = _field1,
				["inline"] = "true"
			}
		}), { ['Content-Type'] = 'application/json' })
	end
end

function DualPlayerLogs(message, color, channel, field1, field2)
	local _field1 = field1
	local _field2 = field2
	if Config.AllLogs then
		if tonumber(Config.channels["all"]) then
			PerformHttpRequest('http://jd-logs.com/api', function(err, text, headers) end, 'POST', json.encode({
				["key"] = Config.secretKey,
				["id"] = Config.channels["all"],
				["author"] = {
					["name"] = Config.communtiyName,
					["icon"] = Config.communtiyLogo
				},
				["title"] = firstToUpper(channel),
				["message"] = message,
				["color"] = color,
				["field1"] = {
					["title"] = "Player 1",
					["message"] = _field1,
					["inline"] = "true"
				},
				["field2"] = {
					["title"] = "Player 2",
					["message"] = _field2,
					["inline"] = "true"
				}
			}), { ['Content-Type'] = 'application/json' })
		end	
  	end
	if tonumber(Config.channels[channel]) then
	PerformHttpRequest('http://jd-logs.com/api', function(err, text, headers) end, 'POST', json.encode({
			["key"] = Config.secretKey,
			["id"] = Config.channels[channel],
			["author"] = {
				["name"] = Config.communtiyName,
				["icon"] = Config.communtiyLogo
			},
			["title"] = firstToUpper(channel),
			["message"] = message,
			["color"] = color,
			["field1"] = {
				["title"] = "Player 1",
				["message"] = _field1,
				["inline"] = "true"
			},
			["field2"] = {
				["title"] = "Player 2",
				["message"] = _field2,
				["inline"] = "true"
			}
		}), { ['Content-Type'] = 'application/json' })
	end
end


-- Event Handlers

-- Send message when Player connects to the server.
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
	local info = GetPlayerDetails(source)
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.\\n'..info, joinColor, 'joins')
end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
	local info = GetPlayerDetails(source)
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..''.._license..''.._ip..'', leaveColor, 'leaving')
end)

-- Send message when Player creates a chat message (Does not show commands)
AddEventHandler('chatMessage', function(source, name, msg)
	local info = GetPlayerDetails(source)
	SinglePlayerLogs('**' .. sanitize(GetPlayerName(source)) .. '**: `'..msg..'`', chatColor, 'chat', GetPlayerDetails(source))
end)

-- Send message when Player died (including reason/killer check) (Not always working)
RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(id,player,killer,DeathReason, Weapon)
	if Weapon == nil then _Weapon = "" else _Weapon = "`"..Weapon.."`" end
	local info = GetPlayerDetails(player)
	if id == 1 then  -- Suicide/died
        SinglePlayerLogs('**' .. sanitize(GetPlayerName(source)) .. '** '..DeathReason..' '.._Weapon, deathColor, 'deaths', GetPlayerDetails(source)) -- sending to deaths channel
	elseif id == 2 then -- Killed by other player
	local _killer = GetPlayerDetails(killer)
	DualPlayerLogs('**' .. GetPlayerName(killer) .. '** '..DeathReason..' ' .. GetPlayerName(source).. ' `('.._Weapon..')`', deathColor, 'deaths', GetPlayerDetails(source), GetPlayerDetails(killer)) -- sending to deaths channel
	else -- When gets killed by something else
        SinglePlayerLogs('**' .. sanitize(GetPlayerName(source)) .. '** `died`', deathColor, 'deaths', GetPlayerDetails(source)) -- sending to deaths channel
	end
end)

-- Send message when Player fires a weapon
RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
	local info = GetPlayerDetails(source)
	if Config.weaponLog then
		SinglePlayerLogs('**' .. sanitize(GetPlayerName(source))  .. '** fired a `' .. weapon .. '`', shootingColor, 'shooting', GetPlayerDetails(source))
    end
end)

-- Getting exports from clientside
RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, id, id2, color, channel)
	if id ~= 0 then
		if id2 ~= 0 then
			local field1 = GetPlayerDetails(id)
			local field2 = GetPlayerDetails(id2)
			DualPlayerLogs(message, color, channel, field1, field2)
		else
			local field1 = GetPlayerDetails(id)
			SinglePlayerLogs(message, color, channel, field1)
		end
	else
		HidePlayerDetails(message, color, channel)
	end
end)

-- Send message when a resource is being stopped
AddEventHandler('onResourceStop', function (resourceName)
    HidePlayerDetails('**' .. resourceName .. '** has been stopped.', Config.resourceColor, 'resources')
end)

-- Send message when a resource is being started
AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    HidePlayerDetails('**' .. resourceName .. '** has been started.', Config.resourceColor, 'resources')
end)

function GetPlayerDetails(src)
	local player_id = src
	local ids = ExtractIdentifiers(player_id)
	local postal = getPlayerLocation(player_id)
	if Config.postal then _postal = "\\n**Nearest Postal:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\\n**Discord ID:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\\n**Steam ID:** " ..ids.steam.."" else _steamID = "\\n**Steam ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\\n**Steam URL:** N/A" end else _steamURL = "" end
	if Config.license then if ids.license ~= "" then _license ="\\n**License:** " ..ids.license else _license = "\\n**License :** N/A" end else _license = "" end
	if Config.IP then if ids.ip ~= "" then _ip ="\\n**IP:** " ..ids.ip else _ip = "\\n**IP :** N/A" end else _ip = "" end
	if Config.playerID then _playerID ="\\n**Player ID:** " ..player_id.."" else _playerID = "" end
	return _playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..''.._license..''.._ip
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function getPlayerLocation(src)

local raw = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
local postals = json.decode(raw)
local nearest = nil

local player = src
local ped = GetPlayerPed(player)
local playerCoords = GetEntityCoords(ped)

local x, y = table.unpack(playerCoords)

	local ndm = -1
	local ni = -1
	for i, p in ipairs(postals) do
		local dm = (x - p.x) ^ 2 + (y - p.y) ^ 2
		if ndm == -1 or dm < ndm then
			ni = i
			ndm = dm
		end
	end

	if ni ~= -1 then
		local nd = math.sqrt(ndm)
		nearest = {i = ni, d = nd}
	end
	_nearest = postals[nearest.i].code
	return _nearest
end

-- version check
Citizen.CreateThread( function()
		SetConvarServerInfo("JD_logs", "V"..Config.versionCheck)
		local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
		if vRaw and Config.versionCheck then
			local v = json.decode(vRaw)
			PerformHttpRequest(
				'https://raw.githubusercontent.com/JokeDevil/JD_logs/master/version.json',
				function(code, res, headers)
					if code == 200 then
						local rv = json.decode(res)
						if rv.version ~= v.version then
							print(
								([[^1-------------------------------------------------------
^1JD_logs
^1UPDATE: V%s AVAILABLE
^1CHANGELOG: %s
^1-------------------------------------------------------^0]]):format(
									rv.version,
									rv.changelog
								)
							)
						end
					else
						print('JD_logs unable to check version')
					end
				end,
				'GET'
			)
		end
	end
)