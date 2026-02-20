extends CharacterBody3D

@export var dialogue_resource: DialogueResource
@export var texture: Texture2D
@export var flippedTexture: bool

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite3D = $Sprite3D
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var hasTarget = false
const SPEED = 5.0


func _ready() -> void:
	sprite.texture = texture
	if flippedTexture:
		sprite.flip_h = true
	
	animationPlayer.play("idle")

func speak():
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start");

func set_target_pos(t_targetPos: Vector3):
	hasTarget = true
	animationPlayer.stop()
	nav_agent.target_position =  t_targetPos

func _physics_process(delta: float) -> void:
	if hasTarget:
		movement()
		
func movement():
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	velocity = direction * SPEED
	animationPlayer.play("walk")
	
	if nav_agent.is_navigation_finished():
		hasTarget = false
		animationPlayer.stop()
		velocity = Vector3.ZERO
		await get_tree().create_timer(2.0).timeout
		animationPlayer.play("idle")
		
	move_and_slide()
