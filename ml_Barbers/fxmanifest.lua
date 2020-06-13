game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Troye#7375 & MrLupo'
description 'A barber shop for RedM.'
version '1.0.0'

client_scripts {
    "client.lua",
    "warmenu.lua",
	'mp_male.lua',
	'mp_female.lua'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua"
}