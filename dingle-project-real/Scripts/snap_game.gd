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

@export var bottomCard: TextureRect
@export var topCard: TextureRect

@export var timeBetweenCards: float
@export var captainReactionTime: float

@export var reward: Evidence


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
	called = false
	previousCard = currentCard
	bottomCard.texture = cardTextures[previousCard-1]
	
	var randCard = values[randi() % values.size()]
	currentCard = randCard
	topCard.texture = cardTextures[currentCard-1]
	
	print(previousCard)
	print(currentCard)
	
	if currentCard == previousCard:
		await get_tree().create_timer(captainReactionTime).timeout
		if !called:
			print("SNAP CAP")
			
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("minigameAction"):
		if currentCard == previousCard:
			called = true
			print("SNAP ME!!!!")
		
