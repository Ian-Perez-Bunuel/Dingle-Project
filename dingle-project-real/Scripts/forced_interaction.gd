extends Area3D

signal interacted

@export var oneUse: bool = false
var used = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if used and oneUse:
		return
	
	used = true
	interact()
	
	
func interact():
	Player.set_can_move(false)
	UI.canOpen = false
	interacted.emit()
	print("Basic Forced Interact - Please link to a function")
