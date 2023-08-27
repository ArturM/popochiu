extends PopochiuGraphicInterface

@onready var sierra_commands: HBoxContainer = %SierraCommands


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	super()
	
	Cursor.replace_frames($Cursor)
	
	$Cursor.hide()
	$Menu.hide()
	
	E.current_command = SierraCommands.Commands.WALK
	sierra_commands.select_command()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if get_global_mouse_position().y < 16.0:
			$Menu.show()
		elif get_global_mouse_position().y > $Menu.size.y and $Menu.visible:
			$Menu.hide()
	elif event is InputEventMouseButton and event.is_pressed():
		match (event as InputEventMouseButton).button_index:
			MOUSE_BUTTON_LEFT:
				if not $Menu.visible and not E.hovered\
				 and E.current_command != SierraCommands.Commands.WALK:
					get_viewport().set_input_as_handled()
			MOUSE_BUTTON_RIGHT:
				get_viewport().set_input_as_handled()
				
				E.current_command = posmod(
					E.current_command + 1, SierraCommands.Commands.size()
				)
				sierra_commands.select_command()
