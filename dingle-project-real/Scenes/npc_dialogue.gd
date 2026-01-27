extends Sprite3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start_node := "start"

func speak():
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start");
