extends PanelContainer

@onready var caption: RichTextLabel = $HBoxContainer/Caption


func _ready() -> void:
	caption.text_show_started.connect(show)
	caption.text_show_finished.connect(hide)
	
	hide()
