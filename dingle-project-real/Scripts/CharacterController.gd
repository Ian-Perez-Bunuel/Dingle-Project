extends CharacterBody3D
class_name Player

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var hasTarget = false

const SPEED = 5.0

static var canMove = true

static func set_can_move(b: bool):
	canMove = b

func _physics_process(delta: float) -> void:
	if hasTarget:
		controlled_movement(delta)
	elif canMove:
		normal_movement(delta)
	
func normal_movement(delta: float):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func set_target_pos(t_targetPos: Vector3):
	hasTarget = true
	nav_agent.target_position =  t_targetPos

func controlled_movement(delta: float):
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	velocity = direction * SPEED
	
	if nav_agent.is_navigation_finished():
		hasTarget = false
		velocity = Vector3.ZERO
		
	move_and_slide()

	
