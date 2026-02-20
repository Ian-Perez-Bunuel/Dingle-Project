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
	caughtGulls = false
	talkedToGull = false
	
	# Random flags
	sawBarFlashback = false
	sawRunningFlashBack = false
	sawSmellingFlashBack = false
	
	guessedAmount = 0
	guessedNames.clear()

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
var seagullEvidence: Evidence = load("res://Resources/seagullEvidence.tres")
var caughtGulls: bool = false
var talkedToGull: bool = false

# Random flags
var sawBarFlashback: bool = false
var sawRunningFlashBack: bool = false
var sawSmellingFlashBack: bool = false
func seenFlashBacksAmount():
	var amount: int = 0
	if sawBarFlashback:
		amount += 1
	if sawRunningFlashBack:
		amount += 1
	if sawSmellingFlashBack:
		amount += 1
	
	return amount

var guessedAmount: int = 0
var guessedNames: Array[String]

func canSeeSelf():
	if seenFlashBacksAmount() >= 3 or hasGuessedAllOthers():
		return true
		
	return false

func addName(n: String):
	if not guessedNames.has(n):
		guessedNames.push_back(n)
		print("Added: ", n)

func hasGuessedAllOthers():
	if guessedNames.size() >= 4:
		return true
	
	return false
