extends AudioStreamPlayer

@onready var hover = load("res://Assets/Audio/ui_hover.mp3")
@onready var select = load("res://Assets/Audio/ui_select.mp3")

func _on_responses_menu_response_focused(response: Control) -> void:
	stream = hover
	play()

func play_select_sound():
	stream = select
	play()
	await finished
