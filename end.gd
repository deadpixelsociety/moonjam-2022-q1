extends Control
class_name End


func _on_Timer_timeout():
	Main.switch_ui("res://title/title_screen.tscn")
