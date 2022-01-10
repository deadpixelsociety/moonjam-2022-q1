extends Scene
class_name Kitchen


func _on_Kitchen_scene_ready():
	if GameState.is_state(GameState.STATE.ROOM_INTRO):
		start_dialogue("kitchen-1")


func _on_timeline_end(timeline: String):
	if GameState.is_state(GameState.STATE.ROOM_INTRO):
		GameState.state = GameState.STATE.MET_HENRY
		goto_scene("res://scenes/foyer.tscn")
