extends SceneCharacter
class_name BoobaCharacter


func interact(node: Node):
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		start_dialogue(node, "foyer-2-booba")
