extends Node
## (G) Data and functions to work with the graphic interface.
# ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
# warning-ignore-all:unused_signal

signal blocked
signal unblocked
signal hidden
signal shown
signal mouse_entered_clickable(clickable: PopochiuClickable)
signal mouse_exited_clickable(clickable: PopochiuClickable)
signal mouse_entered_inventory_item(inventory_item: PopochiuInventoryItem)
signal mouse_exited_inventory_item(inventory_item: PopochiuInventoryItem)
signal dialog_line_started
signal dialog_line_finished
# NOTE Maybe add some signals for clicking objects and items
#signal clicked_clickable(clickable: PopochiuClickable)
#signal clicked_inventory_item(inventory_item: PopochiuInventoryItem)
signal hover_text_shown(info: String)
signal system_text_shown(message: String)
signal continue_clicked # TODO deprecate this
signal history_opened # TODO deprecate this
signal save_requested(slot_text) # TODO deprecate this
signal load_requested # TODO deprecate this
signal continue_requested # TODO deprecate this
signal sound_settings_requested # TODO deprecate this

var is_blocked := false
var template := ""
var commands_dic := {}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready():
	template = PopochiuResources.get_data_value("ui", "template", "")


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func queue_show_system_text(msg: String) -> Callable:
	return func (): await show_system_text(msg)


# Shows a text in the center of the screen. Can be used as the narrator or to
# give instructions to players. The visual style of the node that shows this text
# can be modified in DisplayBox.tscn.
func show_system_text(msg: String) -> void:
#	if not E.playing_queue:
#		block()
	
	if E.cutscene_skipped:
		await get_tree().process_frame
		return
	
	system_text_shown.emit(E.get_text(msg))
	
	await self.continue_clicked
	
#	if not E.playing_queue:
#		unblock()


## Shows a text at the bottom of the screen. It is used to show players the
## name of nodes where the cursor is positioned (e.g. a Prop, a character). Could
## be used to show what will happen when players use left and right click.
func show_hover_text(msg := '') -> void:
	hover_text_shown.emit(msg)


## Makes the Graphic Interface to block.
func block() -> void:
	is_blocked = true
	
	#Cursor.set_cursor(Cursor.Type.WAIT)
	#Cursor.block()
	
	blocked.emit()


## Notifies that graphic interface elements can be unlocked (i.e. when a cutscene
## has ended).
func unblock(wait := false) -> void:
	is_blocked = false
	
	if wait:
		await get_tree().create_timer(0.1).timeout
		
		if is_blocked: return
	
	#Cursor.unlock()
	#Cursor.set_cursor()
	
	unblocked.emit()

## Notifies that the graphic interface should hide.
func hide_interface() -> void:
	hidden.emit()


func queue_hide_interface() -> Callable:
	return func(): hide_interface()


# Notifies that the graphic interface should show.
func show_interface() -> void:
	shown.emit()


func queue_show_interface() -> Callable:
	return func(): show_interface()


## Notifies that the history of events should appear.
func show_history() -> void:
	history_opened.emit()


func show_save(slot_text := "") -> void:
	save_requested.emit(slot_text)


func show_load() -> void:
	load_requested.emit()


func show_sound_settings() -> void:
	sound_settings_requested.emit()


func get_command(id: int) -> String:
	if id > -1 and not commands_dic.has(id):
		prints("[Popochiu] UI command not found:", id)
	
	return (commands_dic.get(id, "") as String)


func get_command_description(id: int) -> String:
	return get_command(id).to_snake_case()
