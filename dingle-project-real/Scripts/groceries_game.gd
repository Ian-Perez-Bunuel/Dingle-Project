extends Control

@export var rowsItems: Array[Grocery]

@export var reward: Evidence
var canMove: bool = false

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
	var invervals: float = get_viewport().get_visible_rect().size.y
	var startingX: float = get_viewport().get_visible_rect().size.x + 100
	
	var i: int
	for item in rowsItems:
		item.position.x = startingX
		item.position.y = i * invervals
		i += 1
	
	await get_tree().create_timer(2.0).timeout
	canMove = true

func end():
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	
	Inventory.add_evidence(reward)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !canMove:
		return
		
	for item in rowsItems:
		item.move()
