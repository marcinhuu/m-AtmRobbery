fx_version 'cerulean'
game 'gta5'

version '1.0.0'

shared_script 'configs/**.lua'

server_script 'server/*.lua'

client_scripts {
    'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
}


