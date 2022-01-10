extends SceneCharacter
class_name JesseAnimeCharacter


func interact(node: Node):
	match GameState.state:
		GameState.STATE.FIND_GROUNDS:
			start_dialogue(node, "foyer-2-jesse")
		GameState.STATE.TIME_TO_LEAVE:
			start_dialogue(node, "foyer-4-jesse")
