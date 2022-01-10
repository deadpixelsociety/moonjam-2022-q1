extends Control
class_name TitleScreen


func _on_StartGame_pressed():
	Main.switch_scene("res://scenes/intro.tscn")
	queue_free()


func _on_Settings_pressed():
	Main.switch_ui("res://settings/settings_screen.tscn")


func _on_Quit_pressed():
	get_tree().quit()
