class_name BassCommands
extends PopochiuCommands


func fallback() -> void:
	if is_instance_valid(E.clicked):
		if E.clicked.last_click_button == MOUSE_BUTTON_LEFT:
			interact()
		else:
			examine()
	elif is_instance_valid(I.clicked):
		if I.clicked.last_click_button == MOUSE_BUTTON_LEFT:
			interact_inventory_item()
		else:
			examine_inventory_item()


func interact() -> void:
	await G.show_system_text("Can't INTERACT with it")


func examine() -> void:
	await G.show_system_text("Can't EXAMINE it")


func interact_inventory_item() -> void:
	pass


func examine_inventory_item() -> void:
	await G.show_system_text('Nothing to see in this item')
