extends RichTextLabel
## Show a text in the form of GUI. Can be used to show game (or narrator)
## messages.
# ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
# warning-ignore-all:unused_signal
# warning-ignore-all:return_value_discarded

signal shown

const DFLT_SIZE := 'dflt_size'


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	set_meta(DFLT_SIZE, size)
	
	# Connect to singletons signals
	G.system_text_shown.connect(_show_text)
	
	close()


func _draw() -> void:
	position = get_parent().size / 2.0 - size / 2.0


func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not visible:
		return
	
	var e: InputEventMouseButton = event
	
	get_viewport().set_input_as_handled()
	
	if e.is_pressed() and e.button_index == MOUSE_BUTTON_LEFT:
		close()
		set_process_input(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PULBIC ░░░░
func appear() -> void:
	show()
	set_process_input(true)


func close() -> void:
	set_process_input(false)
	
	G.continue_clicked.emit()
	
	clear()
	text = ""
	size = get_meta(DFLT_SIZE)
	
	hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _show_text(msg := '') -> void:
	clear()
	text = ""
	size = get_meta(DFLT_SIZE)
	
	# ==== Calculate the width of the node =====================================
	var rt := RichTextLabel.new()
	var lbl := Label.new()
	
	rt.append_text(msg)
	lbl.text = rt.get_parsed_text()
	
	add_child(lbl)
	
	var new_size := lbl.size
	if new_size.x > get_meta(DFLT_SIZE).x:
		new_size.x = get_meta(DFLT_SIZE).x - 16.0
	
	lbl.free()
	rt.free()
	# ===================================== Calculate the width of the node ====
	
#	size = new_size
	append_text('[center]%s[/center]' % msg)
	
	if msg:
		appear()
	else:
		close()
