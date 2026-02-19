extends CharacterBody3D

@export var dialogue_resource: DialogueResource
@export var texture: Texture2D

@onready var sprite: Sprite3D = $Sprite3D
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var hasTarget = false
const SPEED = 5.0

func _ready() -> void:
	sprite.texture = texture

func speak():
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start");

func set_target_pos(t_targetPos: Vector3):
	hasTarget = true
	nav_agent.target_position =  t_targetPos

func _physics_process(delta: float) -> void:
	if hasTarget:
		movement()
		
func movement():
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	velocity = direction * SPEED
	
	if nav_agent.is_navigation_finished():
		hasTarget = false
		velocity = Vector3.ZERO
		
	move_and_slide()
