class_name PopochiuGraphicInterface
extends Control
## Handles the in-game Graphic Interface.
##
## You can extend this class to create your own GUI, or use one of the built-in templates for:
## 2-click context-sensitive, 9 verbs and Sierra style.

## Stack of opened popups.
var popups_stack := []
## Whether a dialog line is being displayed.
var is_showing_dialog_line := false

var _components_map := {}


#region Godot ######################################################################################
func _ready():
	for node: Control in (
		get_tree().get_nodes_in_group("popochiu_gui_component")
		+ get_tree().get_nodes_in_group("popochiu_gui_popup")
	):
		_components_map[node.name] = node
	
	# Connect to singleton signals
	G.blocked.connect(_on_blocked)
	G.unblocked.connect(_on_unblocked)
	G.hidden.connect(_on_hidden)
	G.shown.connect(_on_shown)
	G.system_text_shown.connect(_on_system_text_shown)
	G.system_text_hidden.connect(_on_system_text_hidden)
	G.mouse_entered_clickable.connect(_on_mouse_entered_clickable)
	G.mouse_exited_clickable.connect(_on_mouse_exited_clickable)
	G.mouse_entered_inventory_item.connect(_on_mouse_entered_inventory_item)
	G.mouse_exited_inventory_item.connect(_on_mouse_exited_inventory_item)
	G.dialog_line_started.connect(_on_dialog_line_started)
	G.dialog_line_finished.connect(_on_dialog_line_finished)
	D.dialog_started.connect(_on_dialog_started)
	G.dialog_options_shown.connect(_on_dialog_options_shown)
	D.dialog_finished.connect(_on_dialog_finished)
	I.item_selected.connect(_on_inventory_item_selected)
	
	if E.settings.is_pixel_art_game:
		# Apply this filter so the font doesn't blur
		texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	if E.settings.scale_gui:
		size = get_viewport_rect().size / E.scale
		scale = E.scale
		
		# Adjust nodes with a "text" property that is a String in order to try to prevent glitches
		# when rendering its font
		_adjust_nodes_text(get_children())


#endregion

#region Virtual ####################################################################################
## Called when the GUI is blocked and not intended to handle input events.
func _on_blocked(props := { blocking = true }) -> void:
	pass


## Called when the GUI is unblocked and can handle input events again.
func _on_unblocked() -> void:
	pass


## Called when the GUI is hidden.
func _on_hidden() -> void:
	pass


## Called when the GUI is shown.
func _on_shown() -> void:
	pass


## Called when [method G.show_system_text] is executed. Shows [param msg] in the [SystemText]
## component.
func _on_system_text_shown(msg: String) -> void:
	pass


## Called once the player closes the [SystemText] component by default when clicking anywhere on the
## screen.
func _on_system_text_hidden() -> void:
	pass


## Called when the mouse enters (hovers) [param clickable].
func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	pass


## Called when the mouse exits [param clickable].
func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	pass


## Called when the mouse enters (hovers) [param inventory_item].
func _on_mouse_entered_inventory_item(inventory_item: PopochiuInventoryItem) -> void:
	pass


## Called when the mouse exits [param inventory_item].
func _on_mouse_exited_inventory_item(inventory_item: PopochiuInventoryItem) -> void:
	pass


## Called when a dialog line is said by a [PopochiuCharacter] (this is when
## [method PopochiuCharacter.say] is called.
func _on_dialog_line_started() -> void:
	pass


## Called when a dialog line said by a [PopochiuCharacter] finishes (this is after players click the
## screen anywhere to make the dialog line dissapear).
func _on_dialog_line_finished() -> void:
	pass


## Called when [param dialog] starts (this is afet calling [method PopochiuDialog.start]).
func _on_dialog_started(dialog: PopochiuDialog) -> void:
	pass


## Called when the running [PopochiuDialog] shows its options on screen.
func _on_dialog_options_shown() -> void:
	pass


## Called when [param dialog] finishes (this is afet calling [method PopochiuDialog.stop]).
func _on_dialog_finished(dialog: PopochiuDialog) -> void:
	pass


## Called when [param item] is selected in the inventory (i.e. by clicking it).
func _on_inventory_item_selected(item: PopochiuInventoryItem) -> void:
	pass


## Called by [b]cursor.gd[/b] to get the name of the cursor texture to show.
func _get_cursor_name() -> String:
	return ""


#endregion

#region Public #####################################################################################
## Returns the GUI component which [member Node.name] matches [param component_name].
## GUI components are those nodes that are in any of this groups:
## [code]popochiu_gui_component[/code] and [code]popochiu_gui_popup[/code].
func get_component(component_name: String) -> Control:
	if _components_map.has(component_name):
		return _components_map[component_name]
	else:
		PopochiuUtils.print_warning("No GUI component with name %s" % component_name)
	
	return null


## Returns the name of the cursor texture to show. [code]"normal"[/code] is returned by default.
func get_cursor_name() -> String:
	return "normal" if _get_cursor_name().is_empty() else _get_cursor_name()


#endregion

#region Private ####################################################################################
func _adjust_nodes_text(nodes_array: Array) -> void:
	for node: Node in nodes_array:
		_adjust_nodes_text(node.get_children())
		if not node.get("text") or not typeof(node.get("text")) == TYPE_STRING: continue
		if node.text.length() % 2 != 0:
			node.text += " "


#endregion
