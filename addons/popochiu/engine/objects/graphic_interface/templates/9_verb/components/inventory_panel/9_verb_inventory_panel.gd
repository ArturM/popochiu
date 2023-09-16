extends HBoxContainer

@onready var _box: GridContainer = $Box
@onready var up: TextureButton = $VBoxContainer/Up
@onready var down: TextureButton = $VBoxContainer/Down


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready():
	# Conectarse a las señales del papá de los inventarios
	I.item_added.connect(_add_item)
	I.item_removed.connect(_remove_item)
	
	up.disabled = I.items.is_empty() or I.items.size() <= 8
	down.disabled = I.items.is_empty() or I.items.size() <= 8


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _add_item(item: PopochiuInventoryItem, _animate := true) -> void:
	_box.get_child(0).add_child(item)
	
	item.selected.connect(_change_cursor)
	
	# Common call to all inventories. Should be in the class from where inventory
	# panels will inherit from
	await get_tree().process_frame
	
	I.item_add_done.emit(item)


func _remove_item(item: PopochiuInventoryItem, _animate := true) -> void:
	item.selected.disconnect(_change_cursor)
	
	_box.get_child(0).remove_child(item)
	
	await get_tree().process_frame
	
	I.item_remove_done.emit(item)


func _change_cursor(item: PopochiuInventoryItem) -> void:
	I.set_active_item(item)
