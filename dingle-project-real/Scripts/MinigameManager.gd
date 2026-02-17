extends Node

var minigames : Array[Control]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	seed(Time.get_ticks_usec())

	minigames.clear()
	for n in get_tree().get_nodes_in_group("minigame"):
		if n is Control:
			minigames.append(n as Control)


func activate(t_minigame: String):
	var minigame = null
	
	for m in minigames:
		if m.name == t_minigame:
			minigame = m
	
	if minigame == null:
		print("None found names: ",t_minigame)
		return
	
	if minigame.has_method("start"):
		minigame.start()
