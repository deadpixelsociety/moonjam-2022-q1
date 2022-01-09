extends Control
class_name Start


func _ready():
	Settings.apply_settings()	
	Main.switch_ui("res://title/title_screen.tscn")
	queue_free()
