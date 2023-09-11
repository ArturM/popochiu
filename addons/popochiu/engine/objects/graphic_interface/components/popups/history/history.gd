extends PanelContainer
# warning-ignore-all:return_value_discarded

const DIALOG_LINE := preload('dialog_line.tscn')
const INTERACTION_LINE := preload('interaction_line.tscn')

@onready var lines_list: VBoxContainer = find_child('LinesList')
@onready var empty: Label = %Empty
@onready var lines_scroll: ScrollContainer = %LinesScroll
@onready var close: Button = %Close


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	# Connect to own signals
	gui_input.connect(_check_click)
	
	# Connect to child signals
	close.pressed.connect(_close)
	
	# Connect to singletons signals
	G.history_opened.connect(_show_history)
	
	for c in lines_list.get_children():
		(c as Control).queue_free()
	
	hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _check_click(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed()\
	and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
		_close()


func _show_history() -> void:
	if E.history.is_empty():
		empty.show()
		lines_scroll.hide()
	else:
		empty.hide()
		lines_scroll.show()
	
	for data in E.history:
		var lbl: RichTextLabel
		
		if data.has('character'):
			lbl = DIALOG_LINE.instantiate()
			lbl.text = '[color=%s]%s:[/color] %s' \
			% [
				(data.character as PopochiuCharacter).text_color.to_html(false),
				(data.character as PopochiuCharacter).description,
				data.text
			]
		else:
			lbl = INTERACTION_LINE.instantiate()
			lbl.text = '[color=edf171]%s[/color] on [color=a9ff9f]%s[/color]'\
			% [data.action, data.target]
	
		lines_list.add_child(lbl)
	
	if E.settings.scale_gui:
		scale = Vector2.ONE * E.scale
	
	G.blocked.emit({ blocking = false })
	
	Cursor.set_cursor(Cursor.Type.USE)
	Cursor.block()
	
	_show()


func _close() -> void:
	for c in lines_list.get_children():
		(c as Control).queue_free()
	
	G.done()
	Cursor.unlock()
	
	hide()


func _show() -> void:
	if E.settings.scale_gui:
		scale = Vector2.ONE * E.scale
	
	close.grab_focus()
	
	G.blocked.emit({ blocking = false })
	Cursor.set_cursor(Cursor.Type.USE)
	Cursor.block()
	
	show()
