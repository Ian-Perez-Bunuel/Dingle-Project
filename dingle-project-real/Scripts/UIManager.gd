extends Control

@onready var evidenceBook := $EvidenceBook

func _ready() -> void:
	evidenceBook.visible = false
	
func toggle_show():
	evidenceBook.toggle()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_show()
