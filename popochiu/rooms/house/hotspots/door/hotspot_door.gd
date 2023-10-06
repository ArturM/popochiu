@tool
extends PopochiuHotspot
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.

var suggested_command := NineVerbCommands.Commands.OPEN


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func _on_click() -> void:
	# Replace the call to super.on_click() with your code.
	# E.g. Make the player-controlled character walk to the Hotspot and then say
	# something:
#	await C.player.walk_to_clicked()
#	await C.player.face_clicked()
#	await C.player.say("Can't open it")
	super.on_click()


# When the node is right clicked
func _on_right_click() -> void:
	# Replace the call to super.on_right_click() with your code.
	# E.g. Make the player-controlled character walk to the Hotspot and then say
	# something:
#	await C.player.face_clicked()
#	await C.player.say("A closed door")
	super.on_right_click()


# When the node is clicked and there is an inventory item selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item == I.Key:
		await C.walk_to_clicked()
		await C.face_clicked()
		await item.remove()
		await C.player.say("I'm free!!!")
