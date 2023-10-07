extends Control
class_name PopochiuGraphicInterface
## Handles the in-game Graphic Interface.
# ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
# warning-ignore-all:return_value_discarded

var popups_stack := []
var commands: RefCounted = null


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready():
	# Connect to singleton signals
	G.blocked.connect(_on_gi_blocked)
	G.unblocked.connect(_on_gi_unblocked)
	G.hidden.connect(_hide_panels)
	G.shown.connect(_show_panels)
	G.mouse_entered_clickable.connect(_on_mouse_entered_clickable)
	G.mouse_exited_clickable.connect(_on_mouse_exited_clickable)
	G.mouse_entered_inventory_item.connect(_on_mouse_entered_inventory_item)
	G.mouse_exited_inventory_item.connect(_on_mouse_exited_inventory_item)
	G.dialog_line_started.connect(_on_dialog_line_started)
	G.dialog_line_finished.connect(_on_dialog_line_finished)
	D.dialog_started.connect(_on_dialog_started)
	D.dialog_finished.connect(_on_dialog_finished)
	
#	if E.settings.scale_gui:
#		$MainContainer.scale = E.scale


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
#region virtual
func _on_gi_blocked(props := { blocking = true }) -> void:
	pass


func _on_gi_unblocked() -> void:
	pass


func _hide_panels() -> void:
	pass


func _show_panels() -> void:
	pass


func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	pass


func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	pass


func _on_mouse_entered_inventory_item(inventory_item: PopochiuInventoryItem) -> void:
	pass


func _on_mouse_exited_inventory_item(inventory_item: PopochiuInventoryItem) -> void:
	pass


func _on_dialog_line_started() -> void:
	pass


func _on_dialog_line_finished() -> void:
	pass


func _on_dialog_started(dialog: PopochiuDialog) -> void:
	pass


func _on_dialog_finished(dialog: PopochiuDialog) -> void:
	pass


#endregion
