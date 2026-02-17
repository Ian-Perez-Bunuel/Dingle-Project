extends Area3D

@export var teleport : String
@onready var screen_effect = $"../../CanvasLayer/ColorRect"
@onready var player = $"../../Player"

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	print("teleporting an phiast...")
	match teleport:
		"street_to_dock":
			await transition_stage_1()
			player.global_position = Vector3(100.0,0.0,0.0)
			transition_stage_2()
		"dock_to_street":
			await transition_stage_1()
			player.global_position = Vector3(-75.0,0.5,20.0)
			transition_stage_2()

func transition_stage_1():
	screen_effect.material.set_shader_parameter("invert", true)
	screen_effect.material.set_shader_parameter("progress", 0.0)
	var tween = create_tween()
	tween.tween_property(screen_effect.material, "shader_parameter/progress", 9, 1.0 )
	await tween.finished

func transition_stage_2():
	screen_effect.material.set_shader_parameter("invert", false)
	screen_effect.material.set_shader_parameter("progress", 0.0)
	var tween = create_tween()
	tween.tween_property(screen_effect.material, "shader_parameter/progress", 9, 1.0 )
