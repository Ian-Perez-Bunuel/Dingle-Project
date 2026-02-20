extends Node

var masterSlider: Slider
var masterVol: float = 1.0
var musicSlider: Slider
var musicVol: float = 1.0
var sfxSlider: Slider
var sfxVol: float = 1.0
var uiSfxSlider: Slider
var uiSfxVol: float = 1.0

var masterIndex: int = 0
var musicIndex: int = 0
var sfxIndex: int = 0
var uiSfxIndex: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world := get_tree().current_scene
	masterSlider = world.get_node("UI/Settings/VBoxContainer/MasterSlider") as Slider
	musicSlider = world.get_node("UI/Settings/VBoxContainer/MusicSlider") as Slider
	sfxSlider = world.get_node("UI/Settings/VBoxContainer/SoundEffectsSlider") as Slider
	uiSfxSlider = world.get_node("UI/Settings/VBoxContainer/UISoundEffectsSlider") as Slider
	
	masterIndex = AudioServer.get_bus_index("Master")
	masterSlider.value_changed.connect(update_vol.bind(masterIndex))
	
	musicIndex = AudioServer.get_bus_index("Music")
	musicSlider.value_changed.connect(update_vol.bind(musicIndex))
	
	sfxIndex = AudioServer.get_bus_index("SFX")
	sfxSlider.value_changed.connect(update_vol.bind(sfxIndex))
	
	uiSfxIndex = AudioServer.get_bus_index("UI SFX")
	uiSfxSlider.value_changed.connect(update_vol.bind(uiSfxIndex))
	
func update_vol(value: float, index: int) -> void:
	AudioServer.set_bus_volume_db(index, value)
