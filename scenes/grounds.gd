extends Scene
class_name Grounds


func _on_Grounds_scene_ready():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		GameState.state = GameState.STATE.FIND_EVIDENCE
		start_dialogue("grounds-1")


func _on_GoFoyer_pressed():
	if not GameState.are_evidences_found([ GameState.EVIDENCE.SCRAP, GameState.EVIDENCE.TRACKS, GameState.EVIDENCE.MURDER_WEAPON ]):
		_leaving = false
		start_dialogue("grounds-1-need-evidence")
	else:
		goto_scene("res://scenes/foyer.tscn")
