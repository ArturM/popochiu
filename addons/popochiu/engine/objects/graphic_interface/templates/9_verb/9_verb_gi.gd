extends PopochiuGraphicInterface

@onready var commands_container: GridContainer = %CommandsContainer
@onready var settings_popup: PopochiuPopup = $"Popups/9VerbSettingsPopup"


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	super()
	
	commands = load(
		"res://addons/popochiu/engine/objects/graphic_interface/templates/9_verb/9_verb_commands.gd"
	).new()
	
	Cursor.replace_frames($Cursor)
	Cursor.show_cursor('normal')
	
	$Cursor.hide()
	%HoverTextCentered.hide()
	
	# Connect to child signals
	$BtnSettings.pressed.connect(_on_settings_pressed)
	settings_popup.classic_sentence_toggled.connect(_on_classic_sentence_toggled)
	settings_popup.quit_pressed.connect(_on_quit_pressed)
	
	# Connect to singletons signals
	E.redied.connect(_on_popochiu_ready)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton\
#	and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT\
	and event.is_pressed():
		if E.get_hovered():
			E.clicked = E.get_hovered()
			C.walk_to_clicked()
		else:
			C.player.walk(R.current.get_local_mouse_position())


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _on_gi_blocked(props := { blocking = true }) -> void:
	E.current_command = -1
	G.show_hover_text()


func _on_gi_freed() -> void:
	E.current_command = NineVerbCommands.Commands.WALK_TO
	G.show_hover_text()
	
	for b in commands_container.get_children():
		var btn := b as Button
		btn.set_pressed_no_signal(false)
		
		if btn.has_focus():
			btn.release_focus()


func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	Cursor.show_cursor('active')
	
	if not I.active:
		G.show_hover_text(clickable.description)
	else:
		G.show_hover_text(
			'Use %s with %s' % [I.active.description, clickable.description]
		)


func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	Cursor.show_cursor('normal')
	G.show_hover_text()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _on_settings_pressed() -> void:
	settings_popup.open()


func _on_popochiu_ready() -> void:
	if is_instance_valid(C.player):
		C.player.started_walk_to.connect(_on_player_started_walk)


func _on_player_started_walk(
	_character: PopochiuCharacter, _start_position: Vector2, _end_position: Vector2
) -> void:
	_on_gi_freed()


func _on_classic_sentence_toggled(button_pressed: bool) -> void:
	%HoverTextCursor.visible = not button_pressed
	%HoverTextCentered.visible = button_pressed


func _on_quit_pressed() -> void:
	%QuitPopup.open()
