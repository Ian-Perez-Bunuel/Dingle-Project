extends Area3D

signal interacted


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	interact()
	
	
func interact():
	Player.set_can_move(false)
	interacted.emit()
	print("Basic Forced Interact - Please link to a function")
