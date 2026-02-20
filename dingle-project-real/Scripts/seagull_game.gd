extends Control
class_name Seagull_Minigame

@export var reward: Evidence

var moving: bool = false
var direction: int = 1
var speed: int = 500

@onready var hand = $Net
@export var startHeight: float
@export var endHeight: float
@export var upwardTime: float = 0.5
@export var downwardTime: float = 0.3

@onready var seagull = $Seagull
@onready var seagullSprite = $Seagull/Sprite2D
@export var seagullStartHeight: float

@onready var scoreLabel = $Score
var score: int = 0
var caught: bool = false

var screen_height: float = 0
var screen_width: float = 0

var WIN_CON: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_height = get_viewport_rect().size.y
	screen_width = get_viewport_rect().size.x

	hand.position.y = screen_height - 100
	hand.position.x = screen_width / 2.0
	
	seagull.position.y = 100
	seagull.position.x = screen_width
	
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	score = 0
	caught = false
	moving = false
	scoreLabel.text = "Score: " + str(score)
	Player.set_can_move(false)
	Interactable.set_can_interact(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("minigameAction") and (not moving):
		moving = true
		hand_upward_start()
	
	if caught:
		seagull_caught_movement()
	else:
		seagull_movement(delta)
		

func hand_upward_start():
	var t = create_tween()
	t.tween_property(hand, "position:y", endHeight, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	await t.finished
	hand_downward_start()

func hand_downward_start():
	var t = create_tween()
	t.tween_property(hand, "position:y", startHeight, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	await t.finished
	moving = false
	if caught:
		catch_seagull()

func catch_seagull():
	score_point()
	
	await get_tree().create_timer(0.3).timeout
	caught = false
	seagull.position.y = seagullStartHeight
	if randi() % 2 == 0:
		seagull.position.x = 1
	else:
		seagull.position.x = screen_width - 1
	print("caught")

func seagull_caught_movement():
	seagull.position = hand.position

func seagull_movement(delta: float):
	seagull.position.x += direction * speed * delta
	
	if seagull.position.x <= 0:
		direction = 1
		seagullSprite.flip_h = !seagullSprite.flip_h
	elif seagull.position.x >= screen_width:
		direction = -1
		seagullSprite.flip_h = !seagullSprite.flip_h


func score_point() -> void:
	score += 1
	scoreLabel.text = "Score: " + str(score)
	
	if score >= WIN_CON:
		end()
		
func set_caught(area: Area2D):
	caught = true
	
func end():
	print("ENDED")
	visible = false
	Inventory.add_evidence(reward)
	StoryFlags.caughtGulls = true
	
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	process_mode = Node.PROCESS_MODE_DISABLED
