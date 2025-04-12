extends Node

var pava_en_mano = false
var pava_posiciones_por_escena = {}  # {"res://GameScenes/HouseMain.tscn": Vector2(...), ...}
var pava_node: Node = null  # Aquí almacenamos la referencia al nodo de la pava

# Configuramos la posición inicial de la pava en el living al iniciar
var posicion_inicial: Vector2 = Vector2(633, 966)  # Ajusta esta posición según la escena

func _ready():
	# Si no hay una posición guardada para la habitacion, la asignamos
	var escena_actual = get_tree().current_scene.scene_file_path
	if not pava_posiciones_por_escena.has(escena_actual):
		pava_posiciones_por_escena[escena_actual] = posicion_inicial

# Guardar la posición de la pava en la escena actual
func guardar_pava_en_escena(escena_actual: String):
	if pava_node:
		pava_posiciones_por_escena[escena_actual] = pava_node.position
