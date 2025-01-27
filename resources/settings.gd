class_name settings
extends Resource

const SAVE_SETTINGS_PATH := "user://settings.tres"

@export var musicVolume := 0.5
@export var effectsVolume := 0.5
@export var uiVolume := 0.5

func saveSettings():
	ResourceSaver.save(self,SAVE_SETTINGS_PATH)

static func loadSettings() -> Resource:
	if ResourceLoader.exists(SAVE_SETTINGS_PATH):
		return load(SAVE_SETTINGS_PATH)
	return null
