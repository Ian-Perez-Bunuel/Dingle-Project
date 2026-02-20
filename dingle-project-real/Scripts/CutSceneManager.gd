extends Node

var allObjects : Array[Node3D]
var allPlaces : Array[Node3D]

var screen_effect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	screen_effect = get_tree().current_scene.get_node("TransitionShader/ColorRect")

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

func hide_object(t_objectName: String):
	var object = null
	for o in allObjects:
		if o.name == t_objectName:
			object = o
	
	if (object == null):
		print("Object was not found")
		return
	
	object.visible = false

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

func teleport_to(t_objectName: String, t_placeName: String):
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
	
	object.position = place.position
	
func transition_stage_1():
	screen_effect.material.set_shader_parameter("invert", true)
	screen_effect.material.set_shader_parameter("progress", 0.0)
	var tween = create_tween()
	tween.tween_property(screen_effect.material, "shader_parameter/progress", 9, 1.0 )
	await tween.finished

func transition_stage_2():
	screen_effect.material.set_shader_parameter("invert", false)
	screen_effect.material.set_shader_parameter("progress", 0.0)
	var tween = create_tween()
	tween.tween_property(screen_effect.material, "shader_parameter/progress", 9, 1.0 )
