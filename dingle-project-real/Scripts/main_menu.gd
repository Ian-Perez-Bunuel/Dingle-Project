extends Control

@onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	#teleport an phiast to alley
	player.global_position = Vector3(-105.0, 0.5, -21.0)
	await get_tree().create_timer(0.5).timeout
	hide()


func _on_credits_button_pressed():
	$Credits.show()

func _on_quit_button_pressed():
	get_tree().quit()
