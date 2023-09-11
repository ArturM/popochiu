extends PanelContainer
@warning_ignore("return_value_discarded")

const SELECTION_COLOR := Color('edf171')
const OVERWRITE_COLOR := Color('c46c71')

var _current_slot: Button = null
var _date := ''
var _prev_text := ''
var _slot := 0

@onready var save_load_panel: PanelContainer = $SaveLoadPanel
@onready var title: Label = %Title
@onready var slots: VBoxContainer = %Slots
@onready var ok: Button = %Ok
@onready var close: Button = %Close


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	ok.disabled = true
	
	ok.pressed.connect(_confirmed)
	close.pressed.connect(_close)
	
	var saves: Dictionary = E.get_saves_descriptions()
	
	for btn in slots.get_children():
		(btn as Button).set_meta('has_save', false)
		
		if saves.has(btn.get_index() + 1):
			btn.text = saves[btn.get_index() + 1]
			(btn as Button).set_meta('has_save', true)
		else:
			btn.disabled = true
		
		btn.pressed.connect(_select_slot.bind(btn))
	
	G.save_requested.connect(_show_save)
	G.load_requested.connect(_show_load)
	
	hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _show_save(date: String) -> void:
	title.text = 'Choose a slot to save the game'
	_date = date
	
	for btn in slots.get_children():
		btn.disabled = false
	
	_show()


func _show_load() -> void:
	title.text = 'Choose the slot to load'
	_date = ''
	
	for btn in slots.get_children():
		btn.disabled = !(btn as Button).get_meta('has_save')
	
	_show()


func _show() -> void:
	ok.disabled = true
	_slot = 0
	
	if _current_slot:
		_current_slot.text = _prev_text
		_current_slot.button_pressed = false
		
		_current_slot = null
		_prev_text = ''
	
	if E.settings.scale_gui:
		scale = Vector2.ONE * E.scale
	
	close.grab_focus()
	
	G.blocked.emit({ blocking = false })
	Cursor.set_cursor(Cursor.Type.USE)
	Cursor.block()
	
	show()


func _close() -> void:
	G.done()
	Cursor.unlock()
	
	hide()
	
	if not _slot: return
	
	if _date:
		E.save_game(_slot, _date)
	else:
		E.load_game(_slot)


func _select_slot(btn: Button) -> void:
	if _date:
		if _current_slot:
			_current_slot.text = _prev_text
			_current_slot.button_pressed = false
		
		_current_slot = btn
		_prev_text = _current_slot.text
		_current_slot.text = _date
	else:
		if _current_slot:
			_current_slot.button_pressed = false
		
		_current_slot = btn
		_prev_text = _current_slot.text
	
	ok.disabled = false


func _confirmed() -> void:
	_slot = _current_slot.get_index() + 1
	
	if _date:
		_prev_text = _current_slot.text
		_current_slot.set_meta('has_save', true)
	
	_close()
