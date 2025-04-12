extends Sprite2D

@onready var label = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3
@onready var panel = $Panel
@onready var area = $Area2D
@onready var sound = $AudioStreamPlayer2D
@onready var hide_label_timer = $HideLabelTimer

var ya_rezo = false

func _ready():
	label.visible = false
	label2.visible = false
	label3.visible = false
	panel.visible = false

func _on_area_2d_mouse_shape_entered(_shape_idx: int) -> void:
	label.visible = true
	panel.visible = true

func _on_area_2d_mouse_shape_exited(_shape_idx: int) -> void:
	label.visible = false
	label2.visible = false
	panel.visible = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not GameState.ya_rezo:
			label2.visible = true
			sound.play()
			GameState.ya_rezo = true
		else:
			label3.visible = true
			hide_label_timer.start()
			
func _on_hide_label_timer_timeout():
	label3.visible = false
