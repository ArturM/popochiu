tool
extends PopochiuRoom
# Nodo base para la creación de habitaciones dentro del juego.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func on_room_entered() -> void:
	# Algo así tendrían que quedar los guiones cuando se están programando
	# interacciones.
	if C.player.last_room == 'Cave':
		C.player.global_position = $Points/CavePoint.global_position
	else:
		C.player.global_position = $Points/EntryPoint.global_position
	
	# TODO: No sé si esté bien que esta lógica la tenga la habitación. Tal vez
	# cada Prop, Hotspot, Character, etc. debería validar su propio estado.
	if Globals.game_progress.has(Globals.GameState.GOT_BUCKET) \
		or Globals.game_progress.has(Globals.GameState.LOST_BUCKET):
		$Props/Bucket.queue_free()


func on_room_transition_finished() -> void:
# warning-ignore: unreachable_code
#	return
	E.run_cutscene([
#		G.display('Haz clic para interactuar y clic derecho para examinar'),
#		G.display('DLG_A'),
		'Player: Bueno. Hay que empezar con algo',
		'Barney: Cállese maricón!',
		'Glottis: Holaaaaa',
		'Player: ¡¡¡Un fantasma!!!',
#		E.wait(),
#		C.player.face_up(),
#		E.wait(),
#		C.player.face_left(),
#		E.wait(),
		C.player.face_right(),
		E.wait(),
		C.player_say('Lo importante es empezar')
	])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados