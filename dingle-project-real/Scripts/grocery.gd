extends Button
class_name Grocery

@export var possibleItems: Array[Texture2D]
var speed: float = 5
var canMove: bool = false

func reset(delay: int = 0):
	canMove = false
	var random_item = possibleItems.pick_random()
	icon = random_item
	position.x = get_viewport().get_visible_rect().size.x + 100
	
	var cooldown = randf_range(0.0, 2.5)
	await get_tree().create_timer(cooldown + delay).timeout
	canMove = true

func move():
	if !canMove:
		return
		
	position.x -= speed
	
	if position.x < -200:
		reset()
