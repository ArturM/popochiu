class_name PopochiuCommands
extends RefCounted


func _init() -> void:
	E.register_command(-1, "fallback", fallback)


static func get_script_name() -> String:
	return "PopochiuCommands"


## Called by E when a command doesn't have a command method.
func fallback() -> void:
	print_rich("[rainbow]Da fallback[/rainbow]")
