extends SceneCharacter
class_name ChugsCharacter


func interact(node: Node):
	match GameState.state:
		GameState.STATE.TIME_TO_LEAVE:
			start_dialogue(node, "foyer-4-chugs")
