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
