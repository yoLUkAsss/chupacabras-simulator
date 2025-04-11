extends CharacterBody3D

var player = null
var current_state = "INVISIBLE"
var current_target = CharacterBody3D
var is_hunting = false

@export var player_path: NodePath
@export var distance_wander: float
@export var path_follow: PathFollow3D
@export var monster_speed: int

@onready var nav_agent = $NavigationAgent3D
@onready var prey_detection = $PreyDetectionArea

func _ready() -> void:
	player = get_node(player_path)
	current_state = "CALM_AND_HUNGER"

func _process(delta: float) -> void:
	#pass
	
	match current_state:
		"INVISIBLE":
			#visible = false
			
			pass
		"CALM_AND_HUNGER":
			
			# EN ESTE CASO SERVIRA PARA NOCHE 2 - Distancia del player, pero comiendo vacubis
			if is_hunting:
				_search_and_destroy(current_target)
			else:
				_wander_around(delta)
		"AGGRESSIVE":
			_search_and_destroy(player)
	
	move_and_slide()


func _on_prey_detection_area_body_entered(body: Node3D) -> void:
	if current_state == "CALM_AND_HUNGER":
		current_target = body
		is_hunting = true

func _on_prey_detection_area_body_exited(body: Node3D) -> void:
	is_hunting = false

# PRIVATE FUNCTIONS
func _search_and_destroy(target: Node3D):
	velocity = Vector3.ZERO
	
	nav_agent.target_position = target.global_transform.origin
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * monster_speed
	
	look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)

func _wander_around(delta: float) -> void:
	if path_follow != null:
		path_follow.progress += monster_speed * delta

func _generate_random_position() -> Vector3:
	return Vector3(
		randf_range(position.x-distance_wander, position.x+distance_wander), 
		position.y, 
		randf_range(position.z-distance_wander, position.z+distance_wander)
	)
