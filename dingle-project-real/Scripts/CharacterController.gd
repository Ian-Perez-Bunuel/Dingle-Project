extends CharacterBody3D
class_name Player

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var hasTarget = false
var moving = false

var facing_left = false
const FLIP_SPEED = 0.15
const BASE_SCALE = 0.5

const SPEED = 5.0

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

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
		$AnimationPlayer.play("walk")
		if !$PlayerNoises.playing: # player movement audio
			$PlayerNoises.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animationPlayer.stop()

	if direction.x < 0.0 and not facing_left:
		flip_sprite(true)
	elif direction.x > 0.0 and facing_left:
		flip_sprite(false)


	#if direction: #MAY USE THIS VERSION LATER, maybe combine with the stuff above it
		#moving = true
		#if not $AnimationPlayer.is_playing():
			#$AnimationPlayer.play("walk")
	#else:
		#moving = false
	move_and_slide()

func flip_sprite(flipped: bool):
	var target_x 
	if flipped == true:
		target_x = -BASE_SCALE 
	else:
		target_x = BASE_SCALE 
	
	var tween = create_tween()
	tween.tween_property($Sprite3D, "scale:x", target_x, FLIP_SPEED)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	facing_left = flipped

func set_target_pos(t_targetPos: Vector3):
	hasTarget = true
	nav_agent.target_position =  t_targetPos

func controlled_movement(delta: float):
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	velocity = direction * SPEED
	animationPlayer.play("walk")
	
	if nav_agent.is_navigation_finished():
		hasTarget = false
		animationPlayer.stop()
		velocity = Vector3.ZERO
		
	move_and_slide()

	
