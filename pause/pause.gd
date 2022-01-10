extends Control
class_name Pause


func _on_Resume_pressed():
	get_tree().paused = false
	queue_free()


func _on_Settings_pressed():
	Main.switch_ui("res://settings/settings_screen.tscn")


func _on_Quit_pressed():
	get_tree().quit()
