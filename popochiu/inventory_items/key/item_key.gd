extends PopochiuInventoryItem

const Data := preload('item_key_state.gd')

var state: Data = load('res://popochiu/inventory_items/key/item_key.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods as needed


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the item is clicked in the inventory
func _on_click() -> void:
	# Replace the call to super.on_click() to implement your code.
	super.on_click()


# When the item is right clicked in the inventory
func _on_right_click() -> void:
	E.command_fallback()


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


# ---- 9 verb ------------------------------------------------------------------
func _on_use() -> void:
	I.active = self
	G.show_hover_text("Use %s in" % description)


# ---- Sierra ------------------------------------------------------------------
func _on_interact() -> void:
	I.active = self
	#selected.emit(self)


func _on_look() -> void:
	G.show_system_text("It's the key that opens this room's door")
