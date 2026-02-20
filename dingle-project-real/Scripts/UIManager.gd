extends Control
class_name UI

@onready var evidenceBook := $EvidenceBook
@onready var settings := $Settings

static var canOpen: bool = true
	
func toggle_show():
	show_evidence()
	
func show_evidence():
	print("Show evidence")
	evidenceBook.set_showing(true)
	settings.set_showing(false)

func show_settings():
	print("Show settings")
	evidenceBook.set_showing(false)
	settings.set_showing(true)
	
func _process(delta: float) -> void:
	if not canOpen:
		return
	
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_show()
		visible = !visible
