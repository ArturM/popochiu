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
