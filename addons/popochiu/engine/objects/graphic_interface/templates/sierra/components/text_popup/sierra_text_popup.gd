extends PopochiuPopup

@onready var text_speed: HSlider = %TextSpeed
@onready var dialog_style: OptionButton = %DialogStyle


func _ready() -> void:
	super()
	
	text_speed.value = 0.1 - E.current_text_speed
	dialog_style.selected = E.settings.dialog_style
	
	# Connect to child signals
	text_speed.value_changed.connect(_on_text_speed_changed)
	dialog_style.item_selected.connect(_on_dialog_style_selected)



func _on_text_speed_changed(value: float) -> void:
	E.current_text_speed = 0.1 - value


func _on_dialog_style_selected(idx: int) -> void:
	E.current_dialog_style = dialog_style.get_item_id(idx)
