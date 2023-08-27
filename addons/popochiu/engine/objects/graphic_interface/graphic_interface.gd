extends Control
class_name PopochiuGraphicInterface
## Handles the in-game Graphic Interface.
# ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
# warning-ignore-all:return_value_discarded


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready():
	# Connect to singleton signals
	G.blocked.connect(_disable_panels)
	G.freed.connect(_enable_panels)
	G.interface_hidden.connect(_hide_panels)
	G.interface_shown.connect(_show_panels)
	G.mouse_entered_clickable.connect(_on_mouse_entered_clickable)
	G.mouse_exited_clickable.connect(_on_mouse_exited_clickable)
	
#	if E.settings.scale_gui:
#		$MainContainer.scale = E.scale


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	pass


func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _disable_panels(props := { blocking = true }) -> void:
	pass


func _enable_panels() -> void:
	pass


func _hide_panels() -> void:
	pass


func _show_panels() -> void:
	pass
