extends Control

@export var grocery_holders: Array[Node]

@export var reward: Evidence
var started: bool = false

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
	var invervals: float = get_viewport().get_visible_rect().size.y / grocery_holders.size()
	
	var h: int = 0
	var i: int = 0
	for holder in grocery_holders:
		h += 1
		for item in holder.get_children():
			if item is Grocery:
				item.reset(i)
				item.position.y = h * invervals
				i += 1
		i = 0
	
	await get_tree().create_timer(2.0).timeout
	started = true

func end():
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	
	Inventory.add_evidence(reward)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !started:
		return
		
	for holder in grocery_holders:
		for item in holder.get_children():
			if item is Grocery:
				item.move()
