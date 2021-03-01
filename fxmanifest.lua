author 'JokeDevil'
description 'FXServer logs to Discord (https://www.jokedevil.com/)'
version '1.1.1'
url 'https://jokedevil.com'

-- Config
server_script 'config.lua'
server_script 'config_server.lua'
client_script 'config.lua'

-- Server Scripts
server_script 'server/server.lua'

--Client Scripts
client_script 'client/client.lua'


file 'postals.json'
postal_file 'postals.json'
file 'version.json'

game 'gta5'
fx_version 'cerulean'
