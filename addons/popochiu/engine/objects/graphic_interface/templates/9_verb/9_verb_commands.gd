extends Resource
class_name NineVerbCommands

enum Commands {
	WALK_TO, OPEN, PICK_UP, PUSH, CLOSE, LOOK_AT, PULL, GIVE, TALK_TO, USE
}

var commands_dic := {
	Commands.WALK_TO : "Walk to",
	Commands.OPEN : "Open",
	Commands.PICK_UP : "Pick up",
	Commands.PUSH : "Push",
	Commands.CLOSE : "Close",
	Commands.LOOK_AT : "Look at",
	Commands.PULL : "Pull",
	Commands.GIVE : "Give",
	Commands.TALK_TO : "Talk to",
	Commands.USE : "Use",
}
