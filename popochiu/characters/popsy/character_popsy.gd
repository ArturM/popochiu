@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.

const Data := preload('character_popsy_state.gd')

var state: Data = load('res://popochiu/characters/popsy/character_popsy.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
	pass


# When the node is clicked
func _on_click() -> void:
	# ---- 9 verb ----------------------------------------------------------
	if G.template == "BASS":
		D.ChatWithPopsy.start()
	else:
		match E.current_command:
			NineVerbCommands.Commands.OPEN,\
			NineVerbCommands.Commands.CLOSE,\
			NineVerbCommands.Commands.USE:
				C.Goddiu.say("I can't do that to my epatiu")
			NineVerbCommands.Commands.PUSH,\
			NineVerbCommands.Commands.PULL:
				C.Goddiu.say("We are not playing that anymore")
			NineVerbCommands.Commands.LOOK_AT:
				await C.Goddiu.say("Is my epatiu Popsy")
				await C.Popsy.say("[wave]Hiiiiii![/wave]")
			NineVerbCommands.Commands.GIVE:
				await C.Goddiu.say("I don't have anything to give him")
				await C.Popsy.say("What about a kiss?")
				await C.player.say("Awwwwwww")
	# ---------------------------------------------------------- 9 verb ----


# When the node is right clicked
func _on_right_click() -> void:
	pass


# When the node is clicked and there is an inventory item selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == 'ToyCar':
		await C.Goddiu.say('Take this')
		await I.ToyCar.remove()
		await C.Popsy.say('Thanks!')


# Use it to play the idle animation for the character
func _play_idle() -> void:
	pass


# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func _play_walk(target_pos: Vector2) -> void:
	super(target_pos)


# Use it to play the talk animation for the character
func _play_talk() -> void:
	pass


# Use it to play the grab animation for the character
func _play_grab() -> void:
	pass


# ---- 9 verb ------------------------------------------------------------------
func _on_pick_up() -> void:
	await C.Goddiu.say("Can I pick you up?")
	await C.Popsy.say("I'd prefer you not to do it")


func _on_talk_to() -> void:
	D.ChatWithPopsy.start()


func _on_right_pick_up() -> void:
	prints("Right - Pick up")


func _on_middle_pick_up() -> void:
	prints("Middle - Pick up")
# ------------------------------------------------------------------ 9 verb ----

# ---- SIERRA ------------------------------------------------------------------
func _on_look() -> void:
	C.Goddiu.say("It's my epatiu: Popsy")


func _on_right_look() -> void:
	prints("NO QUIERO QUE ESTO PASE NUNCA JAMÁS!!!")


func _on_interact() -> void:
	C.Goddiu.say("I don't want to do anything with him right now...")


func _on_talk() -> void:
	D.ChatWithPopsy.start()
# ------------------------------------------------------------------ SIERRA ----
