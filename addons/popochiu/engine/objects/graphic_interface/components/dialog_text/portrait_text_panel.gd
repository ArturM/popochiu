extends PanelContainer

@onready var caption: RichTextLabel = $HBoxContainer/Caption
@onready var left_avatar: TextureRect = $HBoxContainer/LeftAvatar
@onready var right_avatar: TextureRect = $HBoxContainer/RightAvatar


func _ready() -> void:
	# Connect to child signals
	caption.text_show_started.connect(show)
	caption.text_show_finished.connect(hide)
	
	# Connect to singletons signals
	C.character_spoke.connect(_update_avatar)
	
	hide()


func _update_avatar(chr: PopochiuCharacter, _msg := '') -> void:
	left_avatar.texture = chr.get_avatar_for_emotion(chr.emotion)
