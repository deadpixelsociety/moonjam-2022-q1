extends Control

onready var _master_volume_val := $OptionsContainer/MasterVolumeVal
onready var _music_volume_val := $OptionsContainer/MusicVolumeVal
onready var _sound_volume_val := $OptionsContainer/SoundVolumeVal
onready var _fullscreen_val := $OptionsContainer/FullscreenVal
onready var _vignette_val := $OptionsContainer/VignetteVal


func _ready():
	_set_values()


func _set_values():
	_master_volume_val.text = str(Settings.master_volume)
	_music_volume_val.text = str(Settings.music_volume)
	_sound_volume_val.text = str(Settings.sound_volume)
	_fullscreen_val.text = "ON" if Settings.fullscreen else "OFF"
	_vignette_val.text = "ON" if Settings.vignette else "OFF"


func _get_values():
	Settings.master_volume = int(_master_volume_val.text)
	Settings.music_volume = int(_music_volume_val.text)
	Settings.sound_volume = int(_sound_volume_val.text)
	Settings.fullscreen = _fullscreen_val.text == "ON"
	Settings.vignette = _vignette_val.text == "ON"


func _on_Apply_pressed():
	Settings.save_settings()
	Settings.apply_settings()
	if get_tree().paused:
		Main.switch_ui("res://pause/pause.tscn")
	else:
		Main.switch_ui("res://title/title_screen.tscn")


func _on_MasterVolumeDec_pressed():
	Settings.master_volume = max(0, Settings.master_volume - 10)
	_set_values()


func _on_MasterVolumeInc_pressed():
	Settings.master_volume = min(100, Settings.master_volume + 10)
	_set_values()


func _on_MusicVolumeDec_pressed():
	Settings.music_volume = max(0, Settings.music_volume - 10)
	_set_values()


func _on_MusicVolumeInc_pressed():
	Settings.music_volume = min(100, Settings.music_volume + 10)
	_set_values()


func _on_SoundVolumeDec_pressed():
	Settings.sound_volume = max(0, Settings.sound_volume - 10)
	_set_values()


func _on_SoundVolumeInc_pressed():
	Settings.sound_volume = min(100, Settings.sound_volume + 10)
	_set_values()


func _on_FullscreenVal_pressed():
	Settings.fullscreen = not Settings.fullscreen
	_set_values()


func _on_VignetteVal_pressed():
	Settings.vignette = not Settings.vignette
	_set_values()


func _on_button_mouse_entered():
	Audio.play_select()
