extends Control

# places to put the info
@export var image1 : TextureRect
@export var image2 : TextureRect
@export var description : Label

# Info on each page
@export var temp : Evidence

var currentPage: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image1.texture = temp.image1
	image2.texture = temp.image2
	description.text = temp.description

func toggle():
	visible = !visible
	
	if visible:
		open()
	else:
		close()
		
func open():
	print("Open")
	if !Inventory.ownedEvidence.is_empty():
		var firstEvidence = Inventory.ownedEvidence[0]
		
		image1.texture = firstEvidence.image1
		image2.texture = firstEvidence.image2
		description.text = firstEvidence.description
		
	else:
		image1.texture = temp.image1
		image2.texture = temp.image2
		description.text = temp.description
		
func close():
	print("Close")
	
func next():
	print("NEXT")
	if (currentPage + 1) >= Inventory.ownedEvidence.size():
		print("CANT GO NEXT")
		return
		
	currentPage += 1
	var e = Inventory.ownedEvidence[currentPage]
		
	image1.texture = e.image1
	image2.texture = e.image2
	description.text = e.description

func prev():
	print("PREV")
	if (currentPage - 1) < 0:
		print("CANT GO BACK")
		return
		
	currentPage -= 1
	var e = Inventory.ownedEvidence[currentPage]
		
	image1.texture = e.image1
	image2.texture = e.image2
	description.text = e.description
