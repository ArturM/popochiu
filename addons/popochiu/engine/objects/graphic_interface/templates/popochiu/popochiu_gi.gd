extends PopochiuGraphicInterface


func _ready() -> void:
	super()
	
	G.mouse_entered_clickable.connect(_on_mouse_hover_clickable.bind(true))
	G.mouse_exited_clickable.connect(_on_mouse_hover_clickable.bind(false))


func _on_mouse_hover_clickable(clickable: PopochiuClickable, is_hover: bool) -> void:
	if is_hover:
		Cursor.set_cursor(clickable.cursor)
		
		if not I.active:
			G.show_hover_text(clickable.description)
		else:
			G.show_hover_text(
				'Use %s with %s' % [I.active.description, clickable.description]
			)
	else:
		Cursor.set_cursor()
		G.show_hover_text()
