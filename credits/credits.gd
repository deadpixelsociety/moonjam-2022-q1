extends Control
class_name Credits


func _on_RichText_meta_clicked(meta):
	OS.shell_open(meta)


func _on_Back_pressed():
	Main.switch_ui("res://title/title_screen.tscn")


func _on_button_mouse_entered():
	Audio.play_select()
