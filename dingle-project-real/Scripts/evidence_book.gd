extends Control

# places to put the info
@export var image1 : TextureRect
@export var image2 : TextureRect
@export var description : Label

# Info on each page
@export var evidence : Evidence

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image1.texture = evidence.image1
	image2.texture = evidence.image2
	description.text = evidence.description
	
