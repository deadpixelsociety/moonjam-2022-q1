extends Scene
class_name Confession


func _ready():
	Audio.play_tension_theme()


func _on_Confession_scene_ready():
	start_dialogue("confession")


func _on_timeline_end(timeline_name: String):
	goto_scene("res://scenes/grounds.tscn")
