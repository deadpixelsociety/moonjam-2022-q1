extends Node

const BUS_MASTER = "Master"
const BUS_MUSIC = "Music"
const BUS_VOICE = "Voice"
const BUS_SOUND = "Sound"

var INVESTIGATION_THEME = preload("res://assets/sfx/investigation-theme--1--loop.wav")

onready var _player := $MusicPlayer


func set_volumes(master_volume: int, music_volume: int, voice_volume: int, sound_volume: int):
	set_bus_volume(BUS_MASTER, master_volume)
	set_bus_volume(BUS_MUSIC, music_volume)
	set_bus_volume(BUS_VOICE, voice_volume)
	set_bus_volume(BUS_SOUND, sound_volume)


func set_bus_volume(bus: String, linear_volume: int):
	var db = linear2db(min(100, max(0, linear_volume)) / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), db)


func get_bus_volume(bus: String) -> int:
	return int(db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))) * 100.0)


func pause():
	_player.playing = false


func resume():
	_player.playing = true


func stop():
	_player.stop()


func play_investigation_theme():
	_player.stream = INVESTIGATION_THEME
	_player.play()
