extends PopochiuHoverText


func _ready() -> void:
	super()
	
	E.current_command = NineVerbCommands.Commands.WALK_TO
	_show_text()


func _show_text(txt := "") -> void:
	if txt.is_empty():
		text = '[center]%s[/center]' % G.get_command(E.current_command)
	else:
		text = '[center]%s %s[/center]' % [G.get_command(E.current_command), txt]
