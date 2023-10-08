extends CanvasLayer

enum Type {
	NONE,
	ACTIVE,
	DOWN,
	IDLE,
	LEFT,
	LOOK,
	RIGHT,
	SEARCH,
	TALK,
	UP,
	USE,
	WAIT,
}

@export var is_pixel_perfect := false

var is_blocked := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
#region Godot
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_cursor()


func _process(delta):
	var texture_size := ($MainCursor.sprite_frames.get_frame_texture(
		$MainCursor.animation,
		$MainCursor.frame
	) as Texture2D).get_size()
	
	var mouse_position: Vector2 = $MainCursor.get_global_mouse_position()
	
	if is_pixel_perfect:
		# Thanks to @whyshchuck
		$MainCursor.position = Vector2i(mouse_position)
		$SecondaryCursor.position = Vector2i(mouse_position)
	else:
		$MainCursor.position = mouse_position
		$SecondaryCursor.position = mouse_position
	
	if $MainCursor.position.x < 1.0:
		$MainCursor.position.x = 1.0
	elif $MainCursor.position.x > 318.0:
		$MainCursor.position.x = 318.0
	
	if $MainCursor.position.y < 1.0:
		$MainCursor.position.y = 1.0
	elif $MainCursor.position.y > 178.0:
		$MainCursor.position.y = 178.0


#endregion
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func show_cursor(anim_name: String, ignore_block := false) -> void:
	if not ignore_block and is_blocked: return
	
	if not $MainCursor.sprite_frames.has_animation(anim_name):
		prints("[Popochiu] Cursor has no animation: %s" % anim_name)
		return
	
	$MainCursor.play(anim_name)
	$MainCursor.show()
	$SecondaryCursor.hide()


func set_secondary_cursor_texture(texture: Texture2D, ignore_block := false) -> void:
	if not ignore_block and is_blocked: return
	
	$SecondaryCursor.texture = texture
	
	#$MainCursor.hide()
	$SecondaryCursor.show()


func remove_secondary_cursor_texture() -> void:
	$SecondaryCursor.texture = null
	
	#$MainCursor.show()
	$SecondaryCursor.hide()


func set_cursor(type := Type.IDLE, ignore_block := false) -> void:
	if not ignore_block and is_blocked: return
	
	# TODO: Temporary fix for mouse cursor change. This need improvements.
	#if E.current_command > -1:
		#show_cursor(G.get_command_description(E.current_command))
		#return
	
	if not Type.values().has(type):
		prints("[Popochiu] Cursor has no type: %s" % type)
		return
	
	var anim_name = Type.keys()[type]
	
	if not $MainCursor.sprite_frames.has_animation(anim_name.to_lower()):
		prints("[Popochiu] Cursor has no animation: %s" % anim_name)
		return
	
	$MainCursor.play(anim_name.to_lower())


func toggle_visibility(is_visible: bool) -> void:
	$MainCursor.visible = is_visible
	$SecondaryCursor.visible = is_visible


func block() -> void:
	is_blocked = true


func unblock() -> void:
	is_blocked = false


func scale_cursor(factor: Vector2) -> void:
	$SecondaryCursor.scale = Vector2.ONE * factor
	$MainCursor.scale = Vector2.ONE * factor


func get_position() -> Vector2:
	return $SecondaryCursor.position


func replace_frames(new_node: AnimatedSprite2D) -> void:
	$MainCursor.sprite_frames = new_node.sprite_frames
	$MainCursor.offset = new_node.offset
