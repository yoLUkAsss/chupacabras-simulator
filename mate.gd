extends Control

@onready var label = $Label
@onready var panel = $Panel
@export var text: String

func _ready():
	panel.visible = false
	label.visible = false
	label.text = text
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

	
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("¡Clic detectado!")

func _on_mouse_entered():
	panel.visible = true
	label.visible = true

func _on_mouse_exited():
	label.visible = false
	panel.visible = false
	
