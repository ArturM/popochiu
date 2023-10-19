class_name SierraCommands
extends PopochiuCommands

enum Commands {
	WALK, LOOK, INTERACT, TALK
}


func _init() -> void:
	super()
	
	E.register_command(Commands.WALK, "Walk", walk)
	E.register_command(Commands.LOOK, "Look", look)
	E.register_command(Commands.INTERACT, "Interact", interact)
	E.register_command(Commands.TALK, "Talk", talk)


static func get_script_name() -> String:
	return "SierraCommands"


func fallback() -> void:
	walk()


func walk() -> void:
#	E.get_node("/root/C").walk_to_clicked()
	C.walk_to_clicked()


func look() -> void:
	G.show_system_text(
		"%s has nothing to say about that object" % C.player.description
	)


func interact() -> void:
	G.show_system_text(
		"%s doesn't want to do anything with that object" % C.player.description
	)


func talk() -> void:
	G.show_system_text(
		"%s can't talk with that" % C.player.description
	)
