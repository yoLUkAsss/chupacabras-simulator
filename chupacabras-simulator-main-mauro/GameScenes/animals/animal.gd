extends CharacterBody3D

@export var moving_speed: float = 1.5
@export var distance_wander: int = 5

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var wander_timer: Timer = $WanderTimer
@onready var eating_timer: Timer = $EatingTimer

var randomPosition: Vector3
var isWalking: bool = false

func _ready() -> void:
	isWalking = true
	nav_agent.target_position = _generate_random_position()
	wander_timer.start()
	

func _physics_process(delta: float) -> void:
	if isWalking:
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * moving_speed
		
		#look_at(Vector3(global_position.x, global_position.y, global_position.z), Vector3.UP)
		
		move_and_slide()


func _on_wander_timer_timeout() -> void:
	print("Voy a frenar a comer")
	isWalking = false
	#eating_timer.wait_time = randi_range(5,10)
	eating_timer.start()

func _on_eating_timer_timeout() -> void:
	print("Voy a caminar un poco loco")
	eating_timer.stop()
	nav_agent.target_position = _generate_random_position()
	wander_timer.start()
	isWalking = true
	
	
# PRIVATE FUNCTIONS
func _generate_random_position() -> Vector3:
	return Vector3(
		randf_range(position.x-distance_wander, position.x+distance_wander), 
		position.y, 
		randf_range(position.z-distance_wander, position.z+distance_wander)
	)

# Esto quiere decir que tengo al monstruo al lado basicamente... debo morir
func _on_monster_detection_area_body_entered(body: Node3D) -> void:
	print("Debo Morir")
	await get_tree().create_timer(3).timeout
	queue_free()
