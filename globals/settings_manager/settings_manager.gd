extends Node

@export_category("Audio:")
@export var defaultMusicVolume : float = 0.6
@export var defaultFxVolume : float = 0.4
@export var defaultUiVolume : float = 0.4

var settings : ConfigFile = ConfigFile.new()
const SETTINGS_FILE_PATH : String = "./settings/settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		settings.set_value("AudioMenu", "MusicVolume", defaultMusicVolume)
		settings.set_value("AudioMenu", "FxVolume", defaultFxVolume)
		settings.set_value("AudioMenu", "UiVolume", defaultUiVolume)
		settings.save(SETTINGS_FILE_PATH)
	else:
		settings.load(SETTINGS_FILE_PATH)

func saveAudioSettings(key : String, value):
	settings.set_value("AudioMenu", key, value)
	settings.save(SETTINGS_FILE_PATH)

func loadAudioSettings():
	var audioSettings = {}
	for key in settings.get_section_keys("AudioMenu"):
		audioSettings[key] = settings.get_value("AudioMenu", key)
	return audioSettings
