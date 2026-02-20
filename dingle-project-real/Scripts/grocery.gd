extends Button
class_name Grocery

var speed: float = 5
var canMove: bool = false

@onready var shadow: TextureRect = $Shadow

enum Type 
{
	Tomato,
	Salt,
	Potato,
	Oil
}

var type: Type = Type.Tomato
@export var itemMap: Dictionary[Type, Texture2D]

func reset(delay: float = 0.0):
	canMove = false
	
	var keys := itemMap.keys()
	if keys.is_empty():
		push_warning("itemMap is empty")
		return
	var key: Type = keys[randi_range(0, keys.size() - 1)]
	type = key
	icon = itemMap[key]
	shadow.texture = icon
	
	position.x = get_viewport().get_visible_rect().size.x + 100
	
	var cooldown = randf_range(0.0, 2.5)
	await get_tree().create_timer(cooldown + delay).timeout
	canMove = true
	visible = true

func move():
	if !canMove:
		return
		
	position.x -= speed
	
	if position.x < -200:
		reset()
		
func collect():
	visible = false
