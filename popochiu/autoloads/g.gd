extends "res://addons/popochiu/engine/interfaces/i_graphic_interface.gd"

var commands_dic := {}


func get_command(id: int) -> String:
	if not commands_dic.has(id):
		prints("[Popochiu] UI command not found.")
	
	return (commands_dic.get(id, "") as String)
