extends Area2D

@export var text: String
@onready var label = $Label
@onready var panel = $Panel

func _ready():
	label.text = text
	panel.visible = false
	label.visible = false

func _on_mouse_entered():
	panel.visible = true
	label.visible = true

func _on_mouse_exited():
	panel.visible = false
	label.visible = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("¡Clic en el objeto!")
