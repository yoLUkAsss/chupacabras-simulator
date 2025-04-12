extends Sprite2D

@onready var label = $Label
@onready var panel = $Panel
@onready var area = $Area2D
@onready var sound = $AudioStreamPlayer2D

var original_position: Vector2
var original_scale: Vector2

func _ready():
	# Obtener referencia a GameState
	var mate_controller = get_tree().root.get_node("MateController")  # Asegúrate de que GameState está en el árbol de nodos

	# Si GameState no tiene el mate, lo asignamos
	if mate_controller.mate_node == null:
		mate_controller.mate_node = self  # Aquí guardamos la referencia al nodo del mate en GameState

	original_position = position
	original_scale = scale

	label.visible = false
	panel.visible = false

	var escena_actual = get_tree().current_scene.scene_file_path

	# Si el mate está en la mano, lo mostramos en el lugar del Holder
	if mate_controller.mate_en_mano:
		var holder = get_parent().get_node_or_null("MateHolder")
		if holder:
			position = holder.global_position
			scale = Vector2(2, 2)
			visible = true
		else:
			print("⚠️ No se encontró MateHolder en la escena")
			visible = false
	# Si ya se guardó la posición del mate en esta escena, lo colocamos ahí
	elif mate_controller.mate_posiciones_por_escena.has(escena_actual):
		position = mate_controller.mate_posiciones_por_escena[escena_actual]
		scale = original_scale
		visible = true
	# Si no hay posición guardada, lo dejamos invisible
	else:
		visible = false  # Esto es necesario para evitar que se muestre en escenas incorrectas


# Funciones de interacción:
func _on_area_2d_mouse_shape_entered(_shape_idx: int) -> void:
	label.visible = true
	panel.visible = true

func _on_area_2d_mouse_shape_exited(_shape_idx: int) -> void:
	label.visible = false
	panel.visible = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var mate_controller = get_tree().root.get_node("MateController")
	var escena_actual = get_tree().current_scene.scene_file_path

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not mate_controller.mate_en_mano:
				mate_controller.mate_en_mano = true
				scale = Vector2(2, 2)

				var holder = get_parent().get_node_or_null("MateHolder")
				if holder:
					position = holder.global_position

				# Lo sacamos de posiciones guardadas si lo estamos tomando
				mate_controller.mate_posiciones_por_escena.erase(escena_actual)
			else:
				mate_controller.mate_en_mano = false
				position = original_position
				scale = original_scale

				# Guardar la posición en esta escena
				mate_controller.guardar_mate_en_escena(escena_actual)

		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if mate_controller.mate_en_mano:
				sound.play()
