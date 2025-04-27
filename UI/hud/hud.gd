extends Control

@onready var runTimer: Timer = $RunTimer
@onready var runTimeDisplay: RichTextLabel = $RunTimeDisplay
@onready var runTimeAnimator: AnimationPlayer = $RunTimeDisplay/RunTimeAnimator

var minutes : int = ProgressionManager.bossTimerMinutes
var seconds : int = ProgressionManager.bossTimerSeconds
var milliSeconds : int = 0
var isFlashing: bool = false

func setRunTimerFlashing(activate : bool) -> void:
	if activate && !runTimeAnimator.is_playing():
		runTimeAnimator.play("RunTimeFlash")
	else:
		runTimeAnimator.play("RESET")

func reset():
	isFlashing = false
	print_debug("resetting")
	runTimeAnimator.play("RESET")
	minutes =  ProgressionManager.bossTimerMinutes
	seconds = ProgressionManager.bossTimerSeconds
	milliSeconds = 0
	print_debug("resetting")
	print_debug(minutes,",",seconds,",",milliSeconds)

func _on_timer_timeout() -> void:
	milliSeconds -= 1
	if milliSeconds < 0:
		seconds -= 1
		milliSeconds = 99
	if seconds < 0:
		seconds = 59
		minutes -= 1
	runTimeDisplay.set_text(format_time())
	runTimer.start()
	if minutes == 0 and seconds == 5 and milliSeconds == 0:
		if !isFlashing:
			isFlashing = true
			setRunTimerFlashing(true)
	if minutes == 0 and seconds == 0 and milliSeconds == 0:
		ProgressionManager.SpawnNextBoss()
		setRunTimerFlashing(false)
		isFlashing = false
		runTimer.stop()

func format_time() -> String:
	return "%02d:%02d:%02d" % [minutes, seconds, milliSeconds]
