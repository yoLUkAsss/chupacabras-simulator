extends Node2D

# Referencias a los nodos
@onready var sprite = $Sprite
@onready var overlay = $Overlay
@onready var label = $Label

# Variable para saber si el mouse está sobre el sprite
var mouse_over = false

# Función para cuando el mouse entra en el área del sprite
func _on_Sprite_mouse_entered():
	mouse_over = true
	overlay.show()  # Mostrar el overlay
	label.text = "¡Estás sobre el objeto!"  # Mostrar el texto
	label.show()

# Función para cuando el mouse sale del área del sprite
func _on_Sprite_mouse_exited():
	mouse_over = false
	overlay.hide()  # Ocultar el overlay
	label.hide()    # Ocultar el texto

# Detectar clics en el sprite
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and mouse_over:
		_on_sprite_clicked()

# Método que se llama cuando se hace clic sobre el sprite
func _on_sprite_clicked():
	print("¡Clic sobre el sprite!")
	# Aquí puedes agregar lo que quieras que ocurra al hacer clic, por ejemplo:
	# Cambiar algo en la escena, iniciar animaciones, etc.
