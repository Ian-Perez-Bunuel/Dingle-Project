extends Control

@export var grocery_holders: Array[Node]
@export var backgrounds: Array[TextureRect]

@export var reward: Evidence
var started: bool = false

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
	var invervals: float = get_viewport().get_visible_rect().size.y / grocery_holders.size()
	
	var h: int = 0
	var d: float = 0
	for holder in grocery_holders:
		for item in holder.get_children():
			if item is Grocery:
				item.reset(d)
				item.position.y = h * invervals
				d += 2.5
		h += 1
		d = 0
	
	await get_tree().create_timer(2.0).timeout
	started = true

func end():
	Player.set_can_move(true)
	Interactable.set_can_interact(true)
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	
	Inventory.add_evidence(reward)
	

func collect():
	print("Collected")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !started:
		return
		
	for holder in grocery_holders:
		for item in holder.get_children():
			if item is Grocery:
				item.move()
				
	for bg in backgrounds:
		bg.position.x -= 5
		
	if backgrounds[0].position.x <= -backgrounds[0].texture.get_width():
		backgrounds[0].position.x = backgrounds[1].position.x + backgrounds[1].texture.get_width()

	if backgrounds[1].position.x <= -backgrounds[1].texture.get_width():
		backgrounds[1].position.x = backgrounds[0].position.x + backgrounds[0].texture.get_width()
