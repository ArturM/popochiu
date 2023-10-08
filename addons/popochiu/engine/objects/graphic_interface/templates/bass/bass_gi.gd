extends PopochiuGraphicInterface


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	super()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _on_system_text_shown(msg: String) -> void:
	G.show_hover_text()
	Cursor.set_cursor(Cursor.Type.WAIT, true)


func _on_system_text_hidden() -> void:
	Cursor.set_cursor()


func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	Cursor.set_cursor(clickable.cursor)
	
	if not I.active:
		G.show_hover_text(clickable.description)
	else:
		G.show_hover_text(
			'Use %s with %s' % [I.active.description, clickable.description]
		)


func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	Cursor.set_cursor()
	G.show_hover_text()


func _on_dialog_line_started() -> void:
	Cursor.set_cursor(Cursor.Type.WAIT)


func _on_dialog_line_finished() -> void:
	Cursor.set_cursor(Cursor.Type.USE if D.current_dialog else Cursor.Type.IDLE)


func _on_dialog_started(dialog: PopochiuDialog) -> void:
	Cursor.set_cursor(Cursor.Type.USE)
	G.show_hover_text()


func _on_dialog_finished(dialog: PopochiuDialog) -> void:
	Cursor.set_cursor()


