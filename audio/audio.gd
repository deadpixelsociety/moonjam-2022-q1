extends Node

const BUS_MASTER = "Master"
const BUS_MUSIC = "Music"
const BUS_VOICE = "Voice"
const BUS_SOUND = "Sound"

var INVESTIGATION_THEME = preload("res://assets/sfx/investigation-theme--1--loop.wav")
var TENSION_THEME = preload("res://assets/sfx/tension.wav")
var SELECT = preload("res://assets/sfx/select.wav")
var TRAY_HIT = preload("res://assets/sfx/tray_hit.wav")

var _playing_investigation = false
var _playing_tension = false

onready var _music_player := $MusicPlayer
onready var _sound_player := $SoundPlayer


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
	_music_player.playing = false


func resume():
	_music_player.playing = true


func stop():
	_music_player.stop()


func play_investigation_theme():
	if _playing_investigation:
		return
	_playing_investigation = true
	_playing_tension = false
	_music_player.stream = INVESTIGATION_THEME
	_music_player.volume_db = linear2db(0.01)
	_music_player.play()
	var anima = Anima.begin(self, "fade_in")
	anima.then({
		node = _music_player,
		property = "volume_db",
		animation = "fade_in",
		from = linear2db(0.01),
		to = linear2db(1.0),
		duration = 2.0
	})
	anima.play()


func play_tension_theme():
	if _playing_tension:
		return
	_playing_tension = true
	_playing_investigation = false
	_music_player.stream = TENSION_THEME
	_music_player.play()


func play_select():
	_sound_player.stream = SELECT
	_sound_player.pitch_scale = rand_range(0.7, 1.0)
	_sound_player.play()


func play_tray_hit():
	_sound_player.stream = TRAY_HIT
	_sound_player.pitch_scale = rand_range(0.5, 1.0)
	_sound_player.play()
