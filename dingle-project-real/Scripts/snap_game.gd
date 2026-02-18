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

@export var WIN_CON: int = 5
var playerScore: int = 0
var captainScore: int = 0

var counter: int = 0
@export var MAX_COUNT: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	values = Card.values()
	values.erase(Card.None)
	
	process_mode = Node.PROCESS_MODE_DISABLED

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
	startGameLoop()
	
	
func end():
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	
	Inventory.add_evidence(reward)
	
	
func startGameLoop() -> void:
	while true:
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
	pile.add_child(newCard)

	print(previousCard)
	print(currentCard)
	
	if currentCard == previousCard:
		await get_tree().create_timer(captainReactionTime).timeout
		if !called:
			print("SNAP CAP")
			captainScore += 1
			captainLabel.text = "Captain's Score: " + str(captainScore)
			reset_pile()
			

func reset_pile():
	previousCard = Card.None
	currentCard = Card.None
	counter = 0
	
	for child in pile.get_children():
		child.queue_free()

func _process(delta: float) -> void:
	if playerScore >= WIN_CON:
		end()
	
	if captainScore >= WIN_CON:
		# Give tag of lost to captain
		end()
	
	if Input.is_action_just_pressed("minigameAction"):
		if currentCard == previousCard && previousCard != Card.None:
			called = true
			reset_pile()
			playerScore += 1
			playerLabel.text = "An Phiast's Score: " + str(playerScore)
			print("SNAP ME!!!!")
		
