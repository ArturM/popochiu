extends "res://addons/popochiu/engine/interfaces/i_graphic_interface.gd"

# ---- 9 verb ------------------------------------------------------------------
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
# ------------------------------------------------------------------ 9 verb ----

# ---- Sierra ------------------------------------------------------------------
#enum Commands {
#	WALK, LOOK, INTERACT, TALK
#}
#
#var commands_dic := {
#	Commands.WALK : "Walk",
#	Commands.LOOK : "Look",
#	Commands.INTERACT : "Interact",
#	Commands.TALK : "Talk",
#}
# ------------------------------------------------------------------ Sierra ----

func get_command(id: int) -> String:
	if not commands_dic.has(id):
		prints("[Popochiu] UI command not found.")
	
	return (commands_dic.get(id, "") as String)
