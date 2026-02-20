extends Node

var timePerFrame: float = 0.5
var loops: float = 3
var displayScreen: Control
var textureRect: TextureRect

enum FlashBack
{
	ClothesFalling,
	Sleeping,
	Bar,
	Running,
	Smelling,
	Eating,
}
var nameToFrames: Dictionary

# Opening
var clothesFallingFrames: Array[Texture2D] = []
var sleepingFrames: Array[Texture2D] = []

# Findables
var barFlashbackFrames: Array[Texture2D] = []
var runningFlashBackFrames: Array[Texture2D] = []
var smellingFlashBackFrames: Array[Texture2D] = []

# Ending
var eatingFlashbackFrames: Array[Texture2D] = []


# Loading flashbacks
func _ready() -> void:
	await get_tree().process_frame
	var world := get_tree().current_scene
	displayScreen = world.get_node("FlashbackDisplay") as Control
	textureRect = world.get_node("FlashbackDisplay/frameTexture") as TextureRect
	
	# Opening
	clothesFallingFrames.append(load("res://Assets/Textures/Flashbacks/intro_part1_0000.png"))
	clothesFallingFrames.append(load("res://Assets/Textures/Flashbacks/intro_part1_0001.png"))
	clothesFallingFrames.append(load("res://Assets/Textures/Flashbacks/intro_part2_0000.png"))
	clothesFallingFrames.append(load("res://Assets/Textures/Flashbacks/intro_part2_0001.png"))
	nameToFrames[FlashBack.ClothesFalling] = clothesFallingFrames
	
	sleepingFrames.append(load("res://Assets/Textures/Flashbacks/intro_part3_0000.png"))
	sleepingFrames.append(load("res://Assets/Textures/Flashbacks/intro_part3_0001.png"))
	nameToFrames[FlashBack.Sleeping] = sleepingFrames
	
	# Findables
	barFlashbackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_party_0000.png"))
	barFlashbackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_party_0001.png"))
	nameToFrames[FlashBack.Bar] = barFlashbackFrames
	
	runningFlashBackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_running_0000.png"))
	runningFlashBackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_running_0001.png"))
	nameToFrames[FlashBack.Running] = runningFlashBackFrames
	
	smellingFlashBackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_smell_0000.png"))
	smellingFlashBackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_smell_0001.png"))
	nameToFrames[FlashBack.Smelling] = smellingFlashBackFrames
	
	# Ending
	eatingFlashbackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_eating_0000.png"))
	eatingFlashbackFrames.append(load("res://Assets/Textures/Flashbacks/flashback_eating_0001.png"))
	nameToFrames[FlashBack.Eating] = eatingFlashbackFrames


func display(fb: FlashBack):
	var i: int = 0
	var l: int = 0
	
	displayScreen.visible = true
	
	while l <= loops:
		textureRect.texture = nameToFrames[fb][i]
		
		await get_tree().create_timer(timePerFrame).timeout
		i += 1
		if i >= nameToFrames[fb].size():
			i = 0
			l += 1
	
	displayScreen.visible = false
	
