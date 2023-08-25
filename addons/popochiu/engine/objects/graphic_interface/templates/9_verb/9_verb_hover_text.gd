extends PopochiuHoverText


func _ready() -> void:
	super()
	
	E.current_command = "Walk to"
	_show_text()


func _show_text(txt := "") -> void:
	if txt.is_empty():
		text = '[center]%s[/center]' % E.current_command
	else:
		text = '[center]%s %s[/center]' % [E.current_command, txt]
