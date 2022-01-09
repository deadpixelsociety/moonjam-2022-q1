extends Control
class_name TitleScreen


func _on_StartGame_pressed():
	Main.switch_scene("res://scenes/foyer.tscn")


func _on_Settings_pressed():
	Main.switch_scene("res://settings/settings_screen.tscn")


func _on_Quit_pressed():
	get_tree().quit()
