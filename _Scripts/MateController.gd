extends Node

var mate_en_mano = false
var mate_posiciones_por_escena = {}  # {"res://GameScenes/HouseMain.tscn": Vector2(...), ...}
var mate_node: Node = null  # Aquí almacenamos la referencia al nodo del mate

# Configuramos la posición inicial del mate en la cocina al iniciar
var posicion_inicial: Vector2 = Vector2(770, 670)  # Ajusta esta posición según la escena

func _ready():
	# Si no hay una posición guardada para la cocina, la asignamos
	var escena_actual = get_tree().current_scene.scene_file_path
	if not mate_posiciones_por_escena.has(escena_actual):
		mate_posiciones_por_escena[escena_actual] = posicion_inicial

# Guardar la posición del mate en la escena actual
func guardar_mate_en_escena(escena_actual: String):
	if mate_node:
		mate_posiciones_por_escena[escena_actual] = mate_node.position
