@tool
extends PopochiuProp
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.

var suggested_command := NineVerbCommands.Commands.PICK_UP


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func _on_click() -> void:
	if E.commands.get_script_name() == NineVerbCommands.get_script_name():
		match E.current_command:
			NineVerbCommands.Commands.OPEN,\
			NineVerbCommands.Commands.CLOSE:
				await C.player.say("Can't do that!")
				await C.player.say("Its all stuck")
			NineVerbCommands.Commands.PUSH,\
			NineVerbCommands.Commands.PULL:
				await C.player.say("Nope...")
			_:
				E.command_fallback()
	elif E.commands.get_script_name() == SierraCommands.get_script_name():
		E.command_fallback()
	else:
		await C.walk_to_clicked()
		await C.face_clicked()
		await C.player.say("Player: I'm gonna take this with me")
		await I.ToyCar.add()


# When the node is right clicked
func _on_right_click() -> void:
	E.command_fallback()


# When the node is clicked and there is an inventory item selected
func _on_item_used(_item: PopochiuInventoryItem) -> void:
	if E.current_command == NineVerbCommands.Commands.GIVE:
		await C.player.say("[rainbow][wave]Oooooohhhh myyyyyyyyy[/wave][/rainbow]")
	else:
		await C.player.say("[shake]Brrrrrr[/shake]")
	
	I.active = null
	G.unblock()


# When an inventory item linked to this Prop (link_to_item) is removed from
# the inventory (i.e. when it is used in something that makes use of the object).
func on_linked_item_removed() -> void:
	pass


# When an inventory item linked to this Prop (link_to_item) is discarded from
# the inventory (i.e. when the player throws the object out of the inventory).
func on_linked_item_discarded() -> void:
	pass

# ---- 9 verb ------------------------------------------------------------------
func _on_look_at() -> void:
	await C.player.say("It is my toy car")
	await C.player.say("I used to play with it")


func _on_pick_up() -> void:
	await C.face_clicked()
	await C.walk_to_clicked()
	await I.ToyCar.add()
	await C.player.say("I'm gonna play with it later")


# ---- Sierra ------------------------------------------------------------------
func _on_look() -> void:
	await G.show_system_text("Its Goddiu's toy car")
	await G.show_system_text("He used to play with it when he was younger")
	await C.player.say("Yup")
