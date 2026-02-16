extends Control

# places to put the info
@export var image1 : TextureRect
@export var image2 : TextureRect
@export var description : Label

# Info on each page
@export var temp : Evidence

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image1.texture = temp.image1
	image2.texture = temp.image2
	description.text = temp.description

func toggle():
	visible = !visible
	
	if Inventory.ownedEvidence.size() > 0:
		var firstEvidence = Inventory.ownedEvidence[0]
		
		image1.texture = firstEvidence.image1
		image2.texture = firstEvidence.image2
		description.text = firstEvidence.description
		
	else:
		image1.texture = temp.image1
		image2.texture = temp.image2
		description.text = temp.description
