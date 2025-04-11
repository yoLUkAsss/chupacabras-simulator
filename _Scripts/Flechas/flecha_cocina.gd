extends Sprite2D

@onready var label = $Label
@onready var panel = $Panel
@onready var area = $Area2D

func _ready():
	label.visible = false
	panel.visible = false
	

func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	label.visible = true
	panel.visible = true
	pass # Replace with function body.


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	label.visible = false
	panel.visible = false
	pass # Replace with function body.


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://GameScenes/HouseLiving.tscn")
