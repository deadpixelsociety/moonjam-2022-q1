extends Control
class_name TitleScreen

onready var _continue_game := $ButtonContainer/ContinueGame


func _ready():
	Audio.play_investigation_theme()
	_continue_game.disabled = not GameState.has_save_state()


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
