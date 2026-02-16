extends Area3D
class_name Interactable

@export var promptMessage := "Interact"
@export var interactionUI: Sprite3D

var player_inside := false
static var canInteract: bool = true

signal interacted

static func set_can_interact(b: bool):
	canInteract = b

func _ready() -> void:
	if interactionUI == null:
		interactionUI = get_node_or_null("Sprite3D")
	if interactionUI:
		interactionUI.visible = false

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _process(delta: float) -> void:
	if canInteract:
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
	Player.set_can_move(false)
	canInteract = false
	interacted.emit()
	print("Basic Interact - Please link to a function")
