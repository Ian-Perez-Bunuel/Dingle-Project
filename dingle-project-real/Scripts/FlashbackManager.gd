extends Node

var timePerFrame: float = 0.5
var loops: float = 3
var displayScreen: Control
var textureRect: TextureRect
var fadeAnimation: AnimationPlayer
var openBadge: TextureRect

var endCard: TextureRect
var endCardFadeAnimation: AnimationPlayer

enum FlashBack
{
	PreClothes,
	ClothesFalling,
	Sleeping,
	Bar,
	Smelling,
	Running,
	Eating,
}
var nameToFrames: Dictionary

# Opening
var preClothesFrames: Array[Texture2D] = []
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
	fadeAnimation = world.get_node("FlashbackDisplay/AnimationPlayer") as AnimationPlayer
	openBadge = world.get_node("FlashbackDisplay/BadgeOpen") as TextureRect
	
	endCardFadeAnimation = world.get_node("FlashbackDisplay/AnimationPlayerEnding") as AnimationPlayer
	endCard = world.get_node("FlashbackDisplay/EndScene") as TextureRect
	
	# Opening
	preClothesFrames.append(load("res://Assets/Textures/Flashbacks/intro_part1_0000.png"))
	preClothesFrames.append(load("res://Assets/Textures/Flashbacks/intro_part1_0001.png"))
	nameToFrames[FlashBack.PreClothes] = preClothesFrames
	
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

func waitFrame():
	await get_tree().process_frame

func show_badge():
	openBadge.visible = true
	
	fadeAnimation.play("show_badge")
	await fadeAnimation.animation_finished
	
	await get_tree().create_timer(4.0).timeout
	fadeAnimation.play("remove_badge")
	await fadeAnimation.animation_finished
	
	openBadge.visible = false

func show_end_card():
	endCard.visible = true
	
	endCardFadeAnimation.play("ShowEndCard")
	await endCardFadeAnimation.animation_finished
	
	await get_tree().create_timer(5.0).timeout
	
	CutSceneManager.show_main_menu()
	StoryFlags.resetFlags()
	
	endCard.visible = false

func display(fb: FlashBack, hasFollowing: bool = false, startBlack: bool = false):
	if not startBlack:
		await fade_to_black()
		
	textureRect.texture = nameToFrames[fb][0]
	textureRect.visible = true
	
	await fade_to_invis()
	
	var i: int = 0
	var l: int = 0
	
	
	while l <= loops:
		textureRect.texture = nameToFrames[fb][i]
		
		await get_tree().create_timer(timePerFrame).timeout
		i += 1
		if i >= nameToFrames[fb].size():
			i = 0
			l += 1
	
	if not hasFollowing:
		await fade_to_black()
		textureRect.visible = false
		await fade_to_invis()

func fade_to_black():
	fadeAnimation.play("fade_to_black")
	await fadeAnimation.animation_finished
	
func fade_to_invis():
	fadeAnimation.play("fade_to_invis")
	await fadeAnimation.animation_finished
