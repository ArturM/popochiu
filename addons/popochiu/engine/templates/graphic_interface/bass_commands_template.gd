extends BassCommands


# Called when `E.command_fallback()` is triggered.
# By default evaluates if the clicked object was a `PopochiuClickable` or a
# `PopochiuInventoryItem` and calls the corresponding method depending on the
# object type and the clicked mouse button.
func fallback() -> void:
	super()


# Called when players click (LMB) a `PopochiuClickable`.
func interact_clickable() -> void:
	super()


# Called when players right click (RMB) a `PopochiuClickable`.
func examine_clickable() -> void:
	super()


# Called when players click (LMB) a `PopochiuInvenoryItem`.
func interact_inventory_item() -> void:
	super()


# Called when players right click (RMB) a `PopochiuInvenoryItem`.
func examine_inventory_item() -> void:
	super()
