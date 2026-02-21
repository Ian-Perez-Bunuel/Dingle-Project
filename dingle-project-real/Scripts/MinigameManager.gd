extends Node

var minigames : Array[Control]

var musicManager: MusicManager
var trackBeforeMinigame: MusicManager.Track

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	seed(Time.get_ticks_usec())
	
	var world := get_tree().current_scene
	musicManager = world.get_node("Music") as AudioStreamPlayer

	minigames.clear()
	for n in get_tree().get_nodes_in_group("minigame"):
		if n is Control:
			minigames.append(n as Control)

func play_bar_theme():
	musicManager.set_music(MusicManager.Track.Bar)

func activate(t_minigame: String):
	trackBeforeMinigame = musicManager.currentTrack
	musicManager.set_music(MusicManager.Track.Minigame)
	
	var minigame = null
	
	for m in minigames:
		if m.name == t_minigame:
			minigame = m
	
	if minigame == null:
		print("None found names: ",t_minigame)
		return
	
	if minigame.has_method("start"):
		minigame.start()

func endedGame():
	musicManager.set_music(trackBeforeMinigame)
