extends Control

@onready var runTimer: Timer = $RunTimer
@onready var runTimeDisplay: RichTextLabel = $RunTimeDisplay
@onready var runTimeAnimator: AnimationPlayer = $RunTimeDisplay/RunTimeAnimator

var minutes : int = 0
var seconds : int = 0
var milliSeconds : int = 0

func setRunTimerFlashing(activate : bool) -> void:
	if activate && !runTimeAnimator.is_playing():
		runTimeAnimator.play("RunTimeFlash")
	else:
		runTimeAnimator.play("RESET")

func reset():
	runTimeAnimator.play("RESET")
	minutes = 0
	seconds = 0
	milliSeconds = 0

func _on_timer_timeout() -> void:
	milliSeconds += 5
	if milliSeconds > 99:
		seconds += 1
		milliSeconds = 0
	if seconds > 59:
		seconds = 0
		minutes += 1
	runTimeDisplay.set_text(format_time())
	runTimer.start()

func format_time() -> String:
	return "%02d:%02d:%02d" % [minutes, seconds, milliSeconds]
