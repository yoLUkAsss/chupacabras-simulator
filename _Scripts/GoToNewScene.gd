extends Sprite2D

@export var Scene: String
func _input(event):
 if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
  if get_rect().has_point(to_local(event.position)):
   get_tree().change_scene_to_file(Scene)
