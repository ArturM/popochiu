@tool
extends PopochiuProp
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.

var suggested_command := NineVerbCommands.Commands.PICK_UP


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func _on_click() -> void:
	E.queue([
		C.queue_walk_to_clicked(),
		C.queue_face_clicked(),
		"Player: Can't open it, but well... who cares about windows anyway. [wave]I'll use the door[/wave].",
		"Player(sad): So....",
		"Player(happy): This is my TOY CAR!!!",
	])


# When the node is right clicked
func _on_right_click() -> void:
	# Replace the call to super.on_right_click() to implement your code.
	# E.g. you can make the character walk to the Prop and then say
	# something:
#	await C.player.face_clicked()
#	await C.player.say("A deck of cards")
	super.on_right_click()


# When the node is clicked and there is an inventory item selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
	if E.current_command == NineVerbCommands.Commands.GIVE:
		await C.player.say("[rainbow][wave]Oooooohhhh myyyyyyyyy[/wave][/rainbow]")
	else:
		await C.player.say("[shake]Brrrrrr[/shake]")
	
	I.active = null
	G.done()


# When an inventory item linked to this Prop (link_to_item) is removed from
# the inventory (i.e. when it is used in something that makes use of the object).
func on_linked_item_removed() -> void:
	pass


# When an inventory item linked to this Prop (link_to_item) is discarded from
# the inventory (i.e. when the player throws the object out of the inventory).
func on_linked_item_discarded() -> void:
	pass


func _on_look_at() -> void:
	await C.player.say("Can't open it, but well... who cares about windows anyway. [wave]I'll use the door[/wave].")
	await C.player.say("So....")
	await C.player.say("This is my TOY CAR!!!")


func _on_pick_up() -> void:
	await C.face_clicked()
	await C.walk_to_clicked()
	await I.ToyCar.add()
	await C.player.say("I'm gonna play with it later")
