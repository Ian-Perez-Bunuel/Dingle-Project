extends Node3D


@export var dialogue_resource: DialogueResource

func speak():
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start");
