extends HBoxContainer

@onready var _box: GridContainer = $Box


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready():
	# Conectarse a las señales del papá de los inventarios
	I.item_added.connect(_add_item)
	I.item_removed.connect(_remove_item)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _add_item(item: PopochiuInventoryItem, animate := true) -> void:
	_box.get_child(0).add_child(item)
	
	item.description_toggled.connect(_show_item_info)
	item.selected.connect(_change_cursor)
	
	I.item_add_done.emit(item)


func _remove_item(item: PopochiuInventoryItem, animate := true) -> void:
	item.description_toggled.disconnect(_show_item_info)
	item.selected.disconnect(_change_cursor)
	
	_box.get_child(0).remove_child(item)
	
	I.item_remove_done.emit(item)


func _show_item_info(description := '') -> void:
	pass


func _change_cursor(item: PopochiuInventoryItem) -> void:
	I.set_active_item(item)
