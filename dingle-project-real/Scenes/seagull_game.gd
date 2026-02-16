extends Control
class_name Seagull_Minigame

var moving: bool = false

var direction: int = 1
var speed: int = 500

@onready var hand = $Hand
@onready var seagull = $Seagull

@onready var scoreLabel = $Score
var score: int = 0

var screen_height: float = 0
var screen_width: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_height = get_viewport_rect().size.y
	screen_width = get_viewport_rect().size.x

	hand.position.y = screen_height - 100
	hand.position.x = screen_width / 2.0
	
	seagull.position.y = 100
	seagull.position.x = screen_width
	
	visible = false

func start():
	visible = true
	score = 0
	scoreLabel.text = str(score)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("minigameAction"):
		moving = true
		
	if moving:
		hand_movement(delta)
		
	seagull_movement(delta)
		
func hand_movement(delta: float):
	if hand.position.y < 0:
		hand.position.y = screen_height - 100
		moving = false
	
	hand.position.y -= 10
	
func seagull_movement(delta: float):
	seagull.position.x += direction * speed * delta

	if seagull.position.x <= 0:
		direction = 1
	elif seagull.position.x >= screen_width:
		direction = -1


func score_point(area: Area2D) -> void:
	print("Collided")
	score += 1
	scoreLabel.text = str(score)
