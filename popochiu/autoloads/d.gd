@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDIntrospection := preload('res://popochiu/dialogs/introspection/dialog_introspection.gd')
# ---- classes

# nodes ----
var Introspection: PDIntrospection : get = get_Introspection
# ---- nodes

# functions ----
func get_Introspection() -> PDIntrospection: return E.get_dialog('Introspection')
# ---- functions

