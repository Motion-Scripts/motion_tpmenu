--[[
    TELEPORT MENU
    Depends: motion_bridge (framework, notify)
    Config: config.lua
--]]

fx_version 'cerulean'
game      'gta5'

name        'tp_menu'
description 'Teleport menu — motion_bridge'
version     '1.0.0'

dependencies { 'motion_bridge' }

ui_page 'html/index.html'

files {
    'html/index.html',
}

shared_scripts {
    '@motion_bridge/bridge.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
    '_versioncheck.lua'
}
