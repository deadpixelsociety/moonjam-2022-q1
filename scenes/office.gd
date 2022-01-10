extends Scene
class_name Office


func _on_Office_scene_ready():
	match GameState.state:
		GameState.STATE.FIND_EVIDENCE:
			start_dialogue("office-1")


func _on_GoFoyer_pressed():
	if not GameState.are_evidences_found([ GameState.EVIDENCE.TRAY, GameState.EVIDENCE.GIFT_CARD ]):
		_leaving = false
		start_dialogue("grounds-1-need-evidence")
	else:
		GameState.state = GameState.STATE.TIME_TO_LEAVE
		goto_scene("res://scenes/foyer.tscn")
