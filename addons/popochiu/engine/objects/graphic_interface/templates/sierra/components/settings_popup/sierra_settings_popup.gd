extends PopochiuPopup

signal option_selected(option_name)

@onready var save: Button = %Save
@onready var load: Button = %Load
@onready var sound: Button = %Sound
@onready var text: Button = %Text


func _ready() -> void:
	super()
	
	save.pressed.connect(_on_option_pressed.bind("save"))
	load.pressed.connect(_on_option_pressed.bind("load"))
	sound.pressed.connect(_on_option_pressed.bind("sound"))
	text.pressed.connect(_on_option_pressed.bind("text"))


func _on_option_pressed(option_name: String) -> void:
	option_selected.emit(option_name)
