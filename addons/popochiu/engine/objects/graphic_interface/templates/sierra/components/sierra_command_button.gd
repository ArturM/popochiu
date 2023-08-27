extends TextureButton

@export var command: G.Commands = 0


func _ready() -> void:
	toggled.connect(on_toggled)


func on_toggled(button_pressed: bool) -> void:
	if button_pressed:
		E.current_command = command
	else:
		E.current_command = G.Commands.WALK
	
	get_parent().select_command()
