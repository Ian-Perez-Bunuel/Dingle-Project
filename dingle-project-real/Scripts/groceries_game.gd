extends Control

@export var grocery_holders: Array[Node]
@export var backgrounds: Array[TextureRect]

@export var reward: Evidence
var started: bool = false

@export var winCons: Dictionary[Grocery.Type, int] # type, amount needed
var currentScore: Dictionary[Grocery.Type, int] # type, amount

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("Buttons"):
		var grocery := node as Grocery
		if grocery:
			grocery.pressed.connect(collect.bind(grocery))
	
	for i in winCons:
		currentScore[i] = 0

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
	var h: int = 0
	var d: float = 0
	for holder in grocery_holders:
		for item in holder.get_children():
			if item is Grocery:
				item.reset(d)
				d += 2.5
		h += 1
		d = 0
	
	await get_tree().create_timer(2.0).timeout
	started = true

func end():
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	UI.canOpen = true
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	
	StoryFlags.completedGroceries = true
	Inventory.add_evidence(reward)
	

func collect(grocery: Grocery):
	print("Button: ", grocery.type)
	currentScore[grocery.type] += 1
	checkForWin()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !started:
		return
		
	for holder in grocery_holders:
		for item in holder.get_children():
			if item is Grocery:
				item.move()
	
	scrollingBG()

func checkForWin():
	for i in winCons:
		if currentScore[i] < winCons[i]: # Didnt win here
			return
	
	end()


func scrollingBG():
	for bg in backgrounds:
		bg.position.x -= 5
		
	if backgrounds[0].position.x <= -backgrounds[0].texture.get_width():
		backgrounds[0].position.x = backgrounds[1].position.x + backgrounds[1].texture.get_width()

	if backgrounds[1].position.x <= -backgrounds[1].texture.get_width():
		backgrounds[1].position.x = backgrounds[0].position.x + backgrounds[0].texture.get_width()
