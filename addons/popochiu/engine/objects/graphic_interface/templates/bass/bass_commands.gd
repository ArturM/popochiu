class_name BassCommands
extends PopochiuCommands


## Called when `E.command_fallback()` is triggered.
func fallback() -> void:
	if is_instance_valid(E.clicked):
		if E.clicked.last_click_button == MOUSE_BUTTON_LEFT:
			interact_clickable()
		else:
			examine_clickable()
	elif is_instance_valid(I.clicked):
		if I.clicked.last_click_button == MOUSE_BUTTON_LEFT:
			interact_inventory_item()
		else:
			examine_inventory_item()


## Called when players click (LMB) a `PopochiuClickable`.
func interact_clickable() -> void:
	await G.show_system_text("Can't INTERACT with it")


## Called when players right click (RMB) a `PopochiuClickable`.
func examine_clickable() -> void:
	await G.show_system_text("Can't EXAMINE it")


## Called when players click (LMB) a `PopochiuInvenoryItem`.
func interact_inventory_item() -> void:
	pass


## Called when players right click (RMB) a `PopochiuInvenoryItem`.
func examine_inventory_item() -> void:
	await G.show_system_text('Nothing to see in this item')
