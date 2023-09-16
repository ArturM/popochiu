@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIIToyCar := preload('res://popochiu/inventory_items/toy_car/item_toy_car.gd')
const PIIKey := preload('res://popochiu/inventory_items/key/item_key.gd')
# ---- classes

# nodes ----
var ToyCar: PIIToyCar : get = get_ToyCar
var Key: PIIKey : get = get_Key
# ---- nodes

# functions ----
func get_ToyCar() -> PIIToyCar: return super.get_item_instance('ToyCar')
func get_Key() -> PIIKey: return super.get_item_instance('Key')
# ---- functions

