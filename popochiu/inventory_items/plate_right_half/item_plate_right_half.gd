extends PopochiuInventoryItem

const Data := preload('item_plate_right_half_state.gd')

var state: Data = load('res://popochiu/inventory_items/plate_right_half/item_plate_right_half.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods as needed


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the item is clicked in the inventory
func _on_click() -> void:
	# Replace the call to super.on_click() to implement your code.
	super.on_click()


# When the item is right clicked in the inventory
func _on_right_click() -> void:
	# Replace the call to super.on_right_click() to implement your code.
	super.on_right_click()


# When the item is clicked and there is another inventory item selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item == I.PlateLeftHalf:
		await I.PlateLeftHalf.remove()
		await replace(I.Plate)
		await C.player.say("[shake]I fixed it!!![/shake]")
		await C.player.say("I'm the best")


# Actions to excecute after the item is added to the Inventory
func _on_added_to_inventory() -> void:
	# Replace the call to super() to implement your code. This only
	# makes the default behavior to happen.
	super()


# Actions to excecute when the item is discarded from the Inventory
func _on_discard() -> void:
	# Replace the call to super() to implement your code. This only
	# makes the default behavior to happen.
	super()


func _on_use() -> void:
	I.active = self
	G.show_hover_text("Use %s in" % description)
