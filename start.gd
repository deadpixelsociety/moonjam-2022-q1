extends Control
class_name Start


func _ready():
	Settings.apply_settings()	
	Main.switch_scene("res://title/title_screen.tscn")
	queue_free()
