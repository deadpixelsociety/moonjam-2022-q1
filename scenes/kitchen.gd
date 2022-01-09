extends Scene
class_name Kitchen


func _on_Kitchen_scene_ready():
	if not GameState.kitchen_dialogue_1:
		GameState.kitchen_dialogue_1 = true
		start_dialogue("kitchen-1")


func _on_timeline_end(timeline: String):
	if not GameState.foyer_dialogue_2:
		Main.switch_scene("res://scenes/foyer.tscn")
