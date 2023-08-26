extends Button

@export var command := G.Commands.WALK_TO


func _ready() -> void:
	pressed.connect(on_pressed)


func on_pressed() -> void:
	E.current_command = command
	G.show_hover_text()
