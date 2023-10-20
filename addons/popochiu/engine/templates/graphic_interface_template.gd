extends PopochiuGraphicInterface


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
## Called when the GUI is blocked and not intended to handle input events.
func _on_blocked(props := { blocking = true }) -> void:
	pass


## Called when the GUI is unblocked and can handle input events again.
func _on_unblocked() -> void:
	pass


## Called to hide the GUI.
func _on_hidden() -> void:
	pass


## Called to show the GUI.
func _on_shown() -> void:
	pass


## Called when G.show_system_text() is triggered. Shows `msg` in the SystemText
## component.
func _on_system_text_shown(msg: String) -> void:
	pass


## Called once the player closes the SystemText component (by clicking the screen
## anywhere).
func _on_system_text_hidden() -> void:
	pass


## Called when the mouse enters (hover) a `clickable`.
func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	pass


## Called when the mouse exits a `clickable`.
func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	pass


## Called when the mouse enters (hover) an `inventory_item`.
func _on_mouse_entered_inventory_item(inventory_item: PopochiuInventoryItem) -> void:
	pass


## Called when the mouse exits an `inventory_item`.
func _on_mouse_exited_inventory_item(inventory_item: PopochiuInventoryItem) -> void:
	pass


## Called when a dialog line is said be a `PopochiuCharacter` (this is when
## `PopochiuCharacter.say()` is called.
func _on_dialog_line_started() -> void:
	pass


## Called when a dialog line finishes (this is after players click the screen
## anywhere to make the dialog line dissapear).
func _on_dialog_line_finished() -> void:
	pass


## Called when a `dialog` starts (afet calling `PopochiuDialog.start()`).
func _on_dialog_started(dialog: PopochiuDialog) -> void:
	pass


## Called when a `dialog` finishes (after calling `PopochiuDialog.stop()`).
func _on_dialog_finished(dialog: PopochiuDialog) -> void:
	pass


## Called when an `item` in the inventory is selected (i.e. by clicking it).
func _on_inventory_item_selected(item: PopochiuInventoryItem) -> void:
	pass

