extends Control
class_name TitleScreen

onready var _continue_game := $TitleContainer/ButtonContainer/ContinueGame
onready var _text_container := $TextContainer
onready var _text1 := $TextContainer/Text1
onready var _text2 := $TextContainer/Text2
onready var _text3 := $TextContainer/Text3
onready var _text4 := $TextContainer/Text4
onready var _text5 := $TextContainer/Text5
onready var _title_container := $TitleContainer


func _ready():
	_continue_game.disabled = not GameState.has_save_state()
	if not GameState.saw_intro:
		_play_intro_animation()
	else:
		_show_title(1.0)
	GameState.saw_intro = true


func _play_intro_animation():
	# Text1
	var anima = Anima.begin(self, "fade_in")
	anima.then({
		node = _text1,
		property = "self_modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	yield(anima, "animation_completed")
	yield(Util.wait(self, 2.0), "timeout")
	anima = Anima.begin(self, "fade_out")
	anima.then({
		node = _text1,
		property = "self_modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	yield(anima, "animation_completed")
	
	# Text2
	anima = Anima.begin(self, "fade_in")
	anima.then({
		node = _text2,
		property = "self_modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	yield(anima, "animation_completed")
	yield(Util.wait(self, 2.0), "timeout")
	anima = Anima.begin(self, "fade_out")
	anima.then({
		node = _text2,
		property = "self_modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	yield(anima, "animation_completed")
	
	# Text3
	anima = Anima.begin(self, "fade_in")
	anima.then({
		node = _text3,
		property = "self_modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	yield(anima, "animation_completed")
	yield(Util.wait(self, 2.0), "timeout")
	anima = Anima.begin(self, "fade_out")
	anima.then({
		node = _text3,
		property = "self_modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	yield(anima, "animation_completed")
	
	# Text4
	anima = Anima.begin(self, "fade_in")
	anima.then({
		node = _text4,
		property = "self_modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	yield(anima, "animation_completed")
	yield(Util.wait(self, 2.0), "timeout")
	anima = Anima.begin(self, "fade_out")
	anima.then({
		node = _text4,
		property = "self_modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	yield(anima, "animation_completed")
	
	# Text5
	anima = Anima.begin(self, "fade_in")
	anima.then({
		node = _text5,
		property = "self_modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	yield(anima, "animation_completed")
	yield(Util.wait(self, 2.0), "timeout")
	anima = Anima.begin(self, "fade_out")
	anima.then({
		node = _text5,
		property = "self_modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	yield(anima, "animation_completed")
	_show_title()


func _show_title(fade_time: float = 2.0):
	_text_container.hide()
	var anima = Anima.begin(self, "show_title")
	anima.then({
		node = _title_container,
		property = "modulate:a",
		animation = "fade_in",
		duration = fade_time
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	Audio.play_investigation_theme()


func _on_StartGame_pressed():
	Main.game_started = true
	Main.switch_scene("res://scenes/intro.tscn")
	queue_free()


func _on_ContinueGame_pressed():
	Main.game_started = true
	GameState.load_state()
	match GameState.current_location:
		GameState.LOCATION.NONE:
			Main.switch_scene("res://scenes/intro.tscn")
		GameState.LOCATION.FOYER:
			Main.switch_scene("res://scenes/foyer.tscn")
		GameState.LOCATION.FRONT:
			Main.switch_scene("res://scenes/manor_front.tscn")
		GameState.LOCATION.GROUNDS:
			Main.switch_scene("res://scenes/grounds.tscn")
		GameState.LOCATION.KITCHEN:
			Main.switch_scene("res://scenes/kitchen.tscn")
		GameState.LOCATION.OFFICE:
			Main.switch_scene("res://scenes/office.tscn")
		GameState.LOCATION.THE_END:
			Main.switch_scene("res://scenes/caught.tscn")
		_:
			_on_StartGame_pressed()
	queue_free()


func _on_Settings_pressed():
	Main.switch_ui("res://settings/settings_screen.tscn")


func _on_Credits_pressed():
	Main.switch_ui("res://credits/credits.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_button_mouse_entered():
	Audio.play_select()
