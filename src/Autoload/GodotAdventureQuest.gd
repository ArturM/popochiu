extends Node
# (E) El núcleo de Godot Adventure Quest

signal inline_dialog_requested(options)

export(Array, Resource) var rooms = []
export(Array, PackedScene) var characters = []
export(Array, String, FILE, "*.tscn") var inventory_items = []
export(Array, Resource) var dialog_trees = []

var in_run := false
# Se usa para que no se pueda cambiar de escena si está se ha cargado por completo,
# esto es que ya ha ejecutado la lógica de Room.on_room_transition_finished
var in_room := false setget _set_in_room
var current_room: Room = null
var clicked: Node

var _cutscene: GDScriptFunctionState = null
var _run_broke := false
# Para saber en qué instrucción se paro la ejecución de una escena (cutscene)
var _break_idx := -1

onready var game_width := get_viewport().get_visible_rect().end.x
onready var game_height := get_viewport().get_visible_rect().end.y
onready var half_width := game_width / 2.0
onready var half_height := game_height / 2.0
onready var _main_camera: Camera2D = find_node('MainCamera')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func _ready() -> void:
	# TODO: Asignar habitaciones, personajes, ítems y árboles de conversación a
	# las respectivas interfaces
	for character_scene in characters:
		var character: Character = character_scene.instance()
		if character.is_player:
			C.player = character
		C.characters.append(character)
	
	set_process_input(false)


func _process(delta: float) -> void:
	if not Engine.editor_hint and is_instance_valid(C.player):
		_main_camera.position = C.player.position


func _input(event: InputEvent) -> void:
	if event.is_action('skip'):
		_run_broke = true
		G.emit_signal('continue_clicked')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func wait(time := 1.0, is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(get_tree().create_timer(time), 'timeout')


# Detiene una cadena de ejecución
func break_run() -> void:
	pass


func run(instructions: Array) -> void:
	G.block()
	
	for idx in instructions.size():
		var instruction = instructions[idx]
		_break_idx = idx
		
		if _run_broke: break

		if instruction is String:
			var i := instruction as String
			
			# TODO: Mover esto a una función que se encargue de evaluar cadenas
			# de texto
			if i == '...':
				yield(wait(1.0, false), 'completed')
			else:
				var char_talk: int = i.find(':')
				if char_talk:
					var char_name: String = i.substr(0, char_talk)
					if not C.is_valid_character(char_name): continue
					var char_line: String = i.substr(char_talk + 1)
					yield(C.character_say(char_name, char_line, false), 'completed')
		elif instruction is GDScriptFunctionState and instruction.is_valid():
			instruction.resume()
			yield(instruction, 'completed')
	
	if not D.active: G.done()


# Es como run, pero salta la secuencia de acciones si se presiona la acción 'skip'.
func run_cutscene(instructions: Array) -> void:
	G.block()

	set_process_input(true)
	yield(run(instructions), 'completed')
	set_process_input(false)
	
	# TODO: Hacer algo para que las instrucciones en el arreglo se ejecuten
	
	G.done()


# Retorna la opción seleccionada en el diálogo creado en tiempo de ejecución.
# NOTA: El flujo del juego se pausa hasta que el jugador seleccione una opción.
func show_inline_dialog(opts: Array) -> String:
	emit_signal('inline_dialog_requested', opts)
	return yield(D, 'option_selected')


func goto_room(path := '') -> void:
# warning-ignore:return_value_discarded
	if not in_room: return
	self.in_room = false

	G.block()

	$TransitionLayer.play_transition('fade_in')
	yield($TransitionLayer, 'transition_finished')
	
	C.player.last_room = current_room.script_name
	
	# Sacar los personajes de la habitación para que no sean eliminados
	current_room.on_room_exited()
	
	for r in rooms:
		var room = r as GAQRoom
		if room.id.to_lower() == path.to_lower():
			get_tree().change_scene(room.path)
			return
	
	printerr('No se encontró la Room %s' % path)


func room_readied(room: Room) -> void:
	current_room = room
	
	# Agregar a la habitación los personajes que tiene configurados
	for c in room.characters:
		var chr: Character = C.get_character(c.script_name)
		if chr:
			chr.position = c.position
#			chr.walk_to_point += chr.position
			room.add_character(chr)
	if room.has_player:
		room.add_character(C.player)
	
	G.done()
	room.on_room_entered()

	$TransitionLayer.play_transition('fade_out')
	yield($TransitionLayer, 'transition_finished')
	yield(wait(0.3, false), 'completed')

	self.in_room = true

	room.on_room_transition_finished()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_in_room(value: bool) -> void:
	in_room = value
	Cursor.toggle_visibility(in_room)