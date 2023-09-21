extends Resource
class_name SierraCommands

enum Commands {
	WALK, LOOK, INTERACT, TALK
}

var commands_dic := {
	Commands.WALK : "Walk",
	Commands.LOOK : "Look",
	Commands.INTERACT : "Interact",
	Commands.TALK : "Talk",
}


static func fallback() -> void:
	walk()


static func walk() -> void:
	E.get_node("/root/C").walk_to_clicked()
#	C.walk_to_clicked()


static func look() -> void:
	G.show_system_text("Nothing to say about this item")
