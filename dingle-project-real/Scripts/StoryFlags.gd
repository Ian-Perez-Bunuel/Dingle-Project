extends Node
#Just holds bools for stuff completed / done by the player

# USED FOR TESTING ONLY
#func _process(delta: float) -> void:
#	if talkedToEvilChippy:
#		print("TRUE")

func resetFlags():
	# Captain flags
	hasBeer = false
	playedSnap = false
	wonSnap = false
	lostSnap = false
	capTalkNoBeer = false
	capAtBoat = false
	capAtSea = false
	
	# Chippy flags
	
	# Evil Chippy flags
	talkedToEvilChippy = false
	completedGroceries = false
	
	# Seagull flags
	
	# Random flags

################### End of Reset Function ###################

# Captain flags
var beerEvidence: Evidence = load("res://Resources/beer.tres")
var hasBeer: bool = false
var capTalkNoBeer: bool = false
var playedSnap: bool = false
var wonSnap: bool = false
var lostSnap: bool = false
var capAtBoat: bool = false
var capAtSea: bool = false

# Chippy flags


# Evil Chippy flags
var evilChippyEvidence: Evidence = load("res://Resources/evilChippyEvidence.tres")
var talkedToEvilChippy: bool = false
var completedGroceries: bool = false

# Seagull flags


# Random flags
