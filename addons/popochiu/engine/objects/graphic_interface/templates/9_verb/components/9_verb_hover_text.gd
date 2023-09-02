extends PopochiuHoverText


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	super()
	
	E.current_command = NineVerbCommands.Commands.WALK_TO
	_show_text()
	
	set_process(get_parent().hover_text_follows_cursor)
	fit_content = get_parent().hover_text_follows_cursor
	autowrap_mode = TextServer.AUTOWRAP_OFF\
	if get_parent().hover_text_follows_cursor\
	else TextServer.AUTOWRAP_WORD_SMART


func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position()
	position -= size / 2.0
	# TODO: Make this value depend of the height of the cursor or a value in
	#       a settings file.
	position.y -= 16.0
	
	# Check viewport limits
	if position.x < 0.0:
		position.x = 0.0
	elif position.x + size.x > E.width:
		position.x = E.width - size.x
	
	if position.y < 0.0:
		position.y = 0.0
	elif position.y + size.y > E.height:
		position.y = E.height - size.y


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _show_text(txt := "") -> void:
	if get_parent().hover_text_follows_cursor:
		text = ""
		size = Vector2.ZERO
	
	if txt.is_empty():
		if E.current_command == NineVerbCommands.Commands.WALK_TO\
		and is_instance_valid(E.get_hovered()):
			text = '[center]%s %s[/center]' % [
				G.get_command(E.current_command), E.get_hovered().description
			]
		elif E.current_command != NineVerbCommands.Commands.WALK_TO:
			text = '[center]%s[/center]' % G.get_command(E.current_command)
	elif not txt.is_empty():
		text = '[center]%s %s[/center]' % [G.get_command(E.current_command), txt]
	
	if get_parent().hover_text_follows_cursor:
		size += Vector2.ONE * 16.0
