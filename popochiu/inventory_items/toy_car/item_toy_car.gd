extends PopochiuInventoryItem

const Data := preload('item_toy_car_state.gd')

var state: Data = load('res://popochiu/inventory_items/toy_car/item_toy_car.tres')


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
	# Replace the call to super.on_item_used(item) to implement your code.
	super.on_item_used(item)


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


func _on_look_at() -> void:
	await C.player.say("It's my toy car")
	await C.player.say("I used to play with it a lot")


func _on_give() -> void:
	I.active = self
	G.show_hover_text("Give %s to" % description)


func _on_use() -> void:
	I.active = self
	G.show_hover_text("Use %s in" % description)
