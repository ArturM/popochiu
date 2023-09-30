@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIIToyCar := preload('res://popochiu/inventory_items/toy_car/item_toy_car.gd')
const PIIKey := preload('res://popochiu/inventory_items/key/item_key.gd')
const PIIPlateLeftHalf := preload('res://popochiu/inventory_items/plate_left_half/item_plate_left_half.gd')
const PIIPlateRightHalf := preload('res://popochiu/inventory_items/plate_right_half/item_plate_right_half.gd')
const PIIPlate := preload('res://popochiu/inventory_items/plate/item_plate.gd')
# ---- classes

# nodes ----
var ToyCar: PIIToyCar : get = get_ToyCar
var Key: PIIKey : get = get_Key
var PlateLeftHalf: PIIPlateLeftHalf : get = get_PlateLeftHalf
var PlateRightHalf: PIIPlateRightHalf : get = get_PlateRightHalf
var Plate: PIIPlate : get = get_Plate
# ---- nodes

# functions ----
func get_ToyCar() -> PIIToyCar: return super.get_item_instance('ToyCar')
func get_Key() -> PIIKey: return super.get_item_instance('Key')
func get_PlateLeftHalf() -> PIIPlateLeftHalf: return super.get_item_instance('PlateLeftHalf')
func get_PlateRightHalf() -> PIIPlateRightHalf: return super.get_item_instance('PlateRightHalf')
func get_Plate() -> PIIPlate: return super.get_item_instance('Plate')
# ---- functions

