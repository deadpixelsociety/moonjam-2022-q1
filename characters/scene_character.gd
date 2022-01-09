extends Resource
class_name SceneCharacter

export(Texture) var portrait
export(String) var character_name
export(String, MULTILINE) var description
export(Color) var color = Color.white


func interact(node: Node):
	pass


func start_dialogue(node: Node, timeline_name: String):
	node.get_tree().root.call_deferred("add_child", Dialogic.start(timeline_name))
