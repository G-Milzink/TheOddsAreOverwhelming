extends Node

const droneReward : int = 1
const dartReward : int = 2

var currentScore : int = 0


func increase_score(amount : int):
	currentScore += amount
	print(currentScore)
