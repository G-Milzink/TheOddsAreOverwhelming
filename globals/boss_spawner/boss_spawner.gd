extends Node



func SpawnNextBoss(bossNumber):
	print_debug("spawning boss: ",bossNumber)
	ProgressionManager.nextBossNumber += 1
	
