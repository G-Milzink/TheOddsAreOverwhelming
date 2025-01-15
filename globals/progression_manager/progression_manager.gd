extends Node

const droneReward : int = 1
const droneArmoredReward : int = 3
const dartReward : int = 2

const blueXtalReward : int = 5

var currentScore : int = 0
var currentScoreDisplay : RichTextLabel 

func _ready() -> void:
	currentScoreDisplay = get_tree().get_first_node_in_group("currentscoredisplay")

func increase_score(amount : int):
	currentScore += amount
	currentScoreDisplay.set_text(str(currentScore))    
	print(currentScore)
