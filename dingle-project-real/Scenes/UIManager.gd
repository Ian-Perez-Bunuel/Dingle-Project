extends Control

@onready var inventory_panel := $EvidenceBook

func _ready() -> void:
	inventory_panel.visible = false
	
func toggle_show():
	inventory_panel.visible = !inventory_panel.visible
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_show()
