extends Area3D
class_name Interactable

@export var promptMessage := "Interact"
@export var interactionUI: Sprite3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start_node := "start"

var player_inside := false

signal interacted

func _ready() -> void:
	if interactionUI == null:
		interactionUI = get_node_or_null("Sprite3D")
	if interactionUI:
		interactionUI.visible = false

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _process(delta: float) -> void:
	if player_inside && Input.is_action_just_pressed("ui_accept"):
		interact()

func _on_body_entered(body: Node) -> void:
	if interactionUI:
		interactionUI.visible = true
	player_inside = true

func _on_body_exited(body: Node) -> void:
	if interactionUI:
		interactionUI.visible = false
	player_inside = false
	
	
func interact():
	interacted.emit()
	print("Basic Interact - Please link to a function")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start");
