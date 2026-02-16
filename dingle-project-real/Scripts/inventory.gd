extends Node

var ownedEvidence: Array[Evidence]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_evidence(e: Evidence):
	ownedEvidence.push_back(e)
