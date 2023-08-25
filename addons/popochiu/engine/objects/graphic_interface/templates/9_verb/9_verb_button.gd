extends Button


func _ready() -> void:
	pressed.connect(on_pressed)


func on_pressed() -> void:
	E.current_command = text
	G.show_hover_text()
