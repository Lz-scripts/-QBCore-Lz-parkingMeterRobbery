fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Park Meter Robbery By Lz-Scripts'
author '!Lahmiiz^'
version '1.0.0'

server_script 'server/*.lua'

client_script {
    'client/client.lua',
    'client/Dispatch.lua',
    'client/targets.lua',
}

shared_script 'config.lua'
