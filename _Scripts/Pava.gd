extends Sprite2D

@onready var area = $Area2D
@onready var panel = $Panel
@onready var label = $Label
@onready var sound = $AudioStreamPlayer2D

var original_position: Vector2
var original_scale: Vector2

func _ready():
	# Obtener referencia a GameState
	var pava_controller = get_tree().root.get_node("PavaController")  # Asegúrate de que GameState está en el árbol de nodos

	# Si GameState no tiene la pava, lo asignamos
	if pava_controller.pava_node == null:
		pava_controller.pava_node = self  # Aquí guardamos la referencia al nodo de la pava en GameState

	original_position = position
	original_scale = scale

	label.visible = false
	panel.visible = false

	var escena_actual = get_tree().current_scene.scene_file_path

	# Si la pava está en la mano, la mostramos en el lugar del Holder
	if pava_controller.pava_en_mano:
		var holder = get_parent().get_node_or_null("PavaHolder")
		if holder:
			position = holder.global_position
			scale = Vector2(2, 2)
			visible = true
		else:
			print("⚠️ No se encontró PavaHolder en la escena")
			visible = false
	# Si ya se guardó la posición de la pava en esta escena, lo colocamos ahí
	elif pava_controller.pava_posiciones_por_escena.has(escena_actual):
		position = pava_controller.pava_posiciones_por_escena[escena_actual]
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
	var pava_controller = get_tree().root.get_node("PavaController")
	var escena_actual = get_tree().current_scene.scene_file_path

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not pava_controller.pava_en_mano:
				pava_controller.pava_en_mano = true
				scale = Vector2(2, 2)

				var holder = get_parent().get_node_or_null("PavaHolder")
				if holder:
					position = holder.global_position

				# Lo sacamos de posiciones guardadas si lo estamos tomando
				pava_controller.pava_posiciones_por_escena.erase(escena_actual)
			else:
				pava_controller.pava_en_mano = false
				position = original_position
				scale = original_scale

				# Guardar la posición en esta escena
				pava_controller.guardar_pava_en_escena(escena_actual)

		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if pava_controller.pava_en_mano:
				sound.play()
