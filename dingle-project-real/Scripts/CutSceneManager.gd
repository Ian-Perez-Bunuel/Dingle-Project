extends Node

var allObjects : Array[Node3D]
var allPlaces : Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame

	allObjects.clear()
	for n in get_tree().get_nodes_in_group("object"):
		if n is Node3D:
			allObjects.append(n as Node3D)

	allPlaces.clear()
	for n in get_tree().get_nodes_in_group("place"):
		if n is Node3D:
			allPlaces.append(n as Node3D)

func end():
	Interactable.set_can_interact(true)
	Player.set_can_move(true)

func move_to(t_objectName: String, t_placeName: String):
	var place = null
	var object = null
	
	for p in allPlaces:
		if p.name == t_placeName:
			place = p
	
	for o in allObjects:
		if o.name == t_objectName:
			object = o
	
	# Check if found
	if (place == null or object == null):
		print("One of the parameters was not found")
		return
	
	if object.has_method("set_target_pos"):
		object.set_target_pos(place.global_position)
	
