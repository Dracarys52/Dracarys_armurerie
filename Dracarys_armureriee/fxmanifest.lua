

fx_version 'adamant'

game 'gta5'


server_script 	'@mysql-async/lib/MySQL.lua' 

client_scripts {
	'dependencies/menu.lua',
	'cl_autres.lua',
	'config.lua'

}

server_scripts {
      'sv_deco.lua',
}



