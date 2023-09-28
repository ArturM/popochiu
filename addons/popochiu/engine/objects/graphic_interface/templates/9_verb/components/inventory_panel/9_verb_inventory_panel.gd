extends HBoxContainer

var rows := 0.0
var max_scroll := 0.0

@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var box: GridContainer = %Box
@onready var up: TextureButton = $ScrollButtons/Up
@onready var down: TextureButton = $ScrollButtons/Down
@onready var slot_size: float = box.get_child(0).size.y
@onready var gap_size: int = box.get_theme_constant("v_separation")


#region Godot
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready():
	# Calculate the number of rows in the box and the max scroll
	var visible_slots := 0
	for slot in box.get_children():
		if slot.visible:
			visible_slots += 1
	rows = visible_slots / box.columns
	max_scroll = ((slot_size + gap_size) * int(rows / 2.0)) + 1.0
	
	# Check if there are inventory items in the scene tree and add them to the
	# Inventory interface class (I)
	for slot in box.get_children():
		if (slot.get_child_count() > 0
		and slot.get_child(0) is PopochiuInventoryItem
		):
			I.items.append(slot.get_child(0).script_name)
	
	# Connect to child signals
	up.pressed.connect(_on_up_pressed)
	down.pressed.connect(_on_down_pressed)
	scroll_container.get_v_scroll_bar().value_changed.connect(_on_scroll)
	
	# Connect to singletons signals
	I.item_added.connect(_add_item)
	I.item_removed.connect(_remove_item)
	
	_check_scroll_buttons()


#endregion
#region Private
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _on_up_pressed() -> void:
	scroll_container.scroll_vertical -= (slot_size + gap_size) + 1.0
	_check_scroll_buttons()


func _on_down_pressed() -> void:
	scroll_container.scroll_vertical += (slot_size + gap_size) + 1.0
	_check_scroll_buttons()


func _add_item(item: PopochiuInventoryItem, _animate := true) -> void:
	box.get_child(0).add_child(item)
	
	item.selected.connect(_change_cursor)
	_check_scroll_buttons()
	
	# Common call to all inventories. Should be in the class from where inventory
	# panels will inherit from
	await get_tree().process_frame
	
	I.item_add_done.emit(item)


func _remove_item(item: PopochiuInventoryItem, _animate := true) -> void:
	item.selected.disconnect(_change_cursor)
	
	box.get_child(0).remove_child(item)
	_check_scroll_buttons()
	
	await get_tree().process_frame
	
	I.item_remove_done.emit(item)


func _change_cursor(item: PopochiuInventoryItem) -> void:
	I.set_active_item(item)


## Checks if the UP and DOWN buttons should be enabled
func _check_scroll_buttons() -> void:
	up.disabled = scroll_container.scroll_vertical == 0
	down.disabled = scroll_container.scroll_vertical >= max_scroll


func _on_scroll(_value: float) -> void:
	_check_scroll_buttons()


#endregion
