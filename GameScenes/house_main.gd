extends Node2D

func DetailOff():
	$Label.visible = false
	$Panel.visible = false

func DetailOn():
	$Label.visible = true
	$Panel.visible = true


func _on_area_2d_mouse_entered() -> void:
	DetailOn()
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	DetailOff()
	pass # Replace with function body.
