extends Area2D

@onready var label = $Label
@export var text: String

func _ready():
	label.visible = false
	label.text = text
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	label.visible = true

func _on_mouse_exited():
	label.visible = false
