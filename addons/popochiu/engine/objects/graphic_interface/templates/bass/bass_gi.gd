extends PopochiuGraphicInterface


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	super()
	
	$Cursor.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _on_system_text_shown(msg: String) -> void:
	G.show_hover_text()
	Cursor.show_cursor("wait", true)


func _on_system_text_hidden() -> void:
	Cursor.show_cursor()


func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	if clickable.get("cursor"):
		Cursor.show_cursor(clickable.cursor)
	
	if not I.active:
		G.show_hover_text(clickable.description)
	else:
		G.show_hover_text(
			'Use %s with %s' % [I.active.description, clickable.description]
		)


func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	Cursor.show_cursor()
	G.show_hover_text()


func _on_dialog_line_started() -> void:
	Cursor.show_cursor("wait")


func _on_dialog_line_finished() -> void:
	Cursor.show_cursor("use" if D.current_dialog else "normal")


func _on_dialog_started(dialog: PopochiuDialog) -> void:
	Cursor.show_cursor("use")
	G.show_hover_text()


func _on_dialog_finished(dialog: PopochiuDialog) -> void:
	Cursor.show_cursor()


