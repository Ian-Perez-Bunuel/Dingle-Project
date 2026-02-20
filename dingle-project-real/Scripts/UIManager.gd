extends Control

@onready var evidenceBook := $EvidenceBook
@onready var settings := $Settings

	
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
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_show()
		visible = !visible
