extends Node

const droneReward : int = 1
const droneArmoredReward : int = 3
const dartReward : int = 2

const blueXtalReward : int = 5

var currentScore : int = 0
var currentScoreDisplay : RichTextLabel 

var spawnDelay : float = 1.5
var currentWave : int = 1

func _ready() -> void:
	currentScoreDisplay = get_tree().get_first_node_in_group("currentscoredisplay")
	print("wave: ", currentWave)

func _process(_delta: float) -> void:
	if currentScore >= 50 && currentWave == 1:
		currentWave += 1
		spawnDelay *= .9
		print("wave: ", currentWave)
	if currentScore >= 100 && currentWave == 2:
		currentWave += 1
		spawnDelay *= .9
		print("wave: ", currentWave)

func increase_score(amount : int):
	currentScore += amount
	currentScoreDisplay.set_text(str(currentScore))    
