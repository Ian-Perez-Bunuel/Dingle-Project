extends Control

enum Card
{
	None,
	One,
	Two,
	Three,
	Four
}
var values

var previousCard: Card = Card.None
var currentCard: Card = Card.None
var called: bool = false
@export var cardTextures: Array[Texture2D]

@export var timeBetweenCards: float
@export var captainReactionTime: float

@export var reward: Evidence

@onready var pile: Control = $Pile
@onready var playerLabel: Label = $PlayerScore
@onready var captainLabel: Label = $CaptainScore

@onready var capAnimator: AnimationPlayer = $CaptainHand/AnimationPlayer
@onready var playerAnimator: AnimationPlayer = $PlayerHand/AnimationPlayer
@onready var pileAnimator: AnimationPlayer = $PileAnimations
var pilePos: Vector2

@export var WIN_CON: int = 5
var playerScore: int = 0
var captainScore: int = 0

var counter: int = 0
@export var MAX_COUNT: int = 10

var playing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	values = Card.values()
	values.erase(Card.None)
	pilePos = get_viewport().get_visible_rect().size / 2
	pilePos.x -= pile.size.x / 2.0
	pilePos.y -= pile.size.y / 2.0
	
	process_mode = Node.PROCESS_MODE_DISABLED

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	playing = true
	
	startGameLoop()
	
	
func end():
	StoryFlags.playedSnap = true
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	UI.canOpen = true
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	playing = false
	
	Inventory.add_evidence(reward)
	
	
func startGameLoop() -> void:
	while playing:
		await get_tree().create_timer(timeBetweenCards).timeout
		addCard()


func addCard():
	counter += 1
	
	called = false
	previousCard = currentCard
	
	var randCard: Card 
	# Stops it from going too long
	if counter >= MAX_COUNT:
		randCard = previousCard
		counter = 0
	else:
		randCard = values[randi() % values.size()]
		
	currentCard = randCard
	
	var newCard = TextureRect.new()
	newCard.texture = cardTextures[currentCard-1]
	newCard.stretch_mode = TextureRect.STRETCH_SCALE
	newCard.size = newCard.texture.get_size()
	newCard.pivot_offset = Vector2(newCard.size.x / 2.0, newCard.size.y / 2.0)
	newCard.rotation = randf_range(0.0, 180.0)
	newCard.position.x += 1200
	pile.add_child(newCard)
	# tween onto the table
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(newCard, "position:x", 0.0, 0.25)

	print(previousCard)
	print(currentCard)
	
	if currentCard == previousCard:
		playing = false
		await get_tree().create_timer(captainReactionTime).timeout
		if !called:
			capAnimator.play("snap")
			await capAnimator.animation_finished
			
			captainScore += 1
			captainLabel.text = "Captain's Score: " + str(captainScore)
			reset_pile()

func reset_pile():
	pileAnimator.play("reset")
	await pileAnimator.animation_finished
		
	previousCard = Card.None
	currentCard = Card.None
	counter = 0
	
	playing = true
	startGameLoop()
	
	pile.position = pilePos
	
	for child in pile.get_children():
		child.queue_free()

func _process(delta: float) -> void:
	if playerScore >= WIN_CON:
		StoryFlags.wonSnap = true
		end()
	
	if captainScore >= WIN_CON:
		StoryFlags.lostSnap = true
		end()
	
	if Input.is_action_just_pressed("minigameAction"):
		if currentCard == previousCard && previousCard != Card.None:
			called = true
			playerAnimator.play("snap")
			await playerAnimator.animation_finished
			
			reset_pile()
			playerScore += 1
			playerLabel.text = "An Phiast's Score: " + str(playerScore)
		
