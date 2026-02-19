extends AudioStreamPlayer

@onready var hover = load("res://Assets/Audio/ui_hover.ogg")
@onready var select = load("res://Assets/Audio/ui_select.ogg")

func _on_responses_menu_response_focused(response: Control) -> void:
	stream = hover
	play()

func play_select_sound():
	stream = select
	play()
	await finished
