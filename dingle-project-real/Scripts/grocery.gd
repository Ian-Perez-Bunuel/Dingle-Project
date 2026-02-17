extends Button
class_name Grocery

var possibleItems: Array[Texture2D]
var speed: float = 100

func reset():
	var random_item = possibleItems.pick_random()
	icon = random_item

func move():
	position.x -= speed
