extends HBoxContainer


func select_command() -> void:
	for b in get_children():
		(b as TextureButton).set_pressed_no_signal(false)
	
	(get_child(E.current_command) as TextureButton).set_pressed_no_signal(true)
	Cursor.play_animation(G.get_command(E.current_command).to_snake_case())
