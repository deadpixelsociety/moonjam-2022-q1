extends Resource
class_name Interactable

export(Texture) var texture
export(String) var interactable_name
export(String) var timeline_name
export(Color) var color = Color.white


func interact(node: Node):
	start_dialogue(node)


func start_dialogue(node: Node):
	if not timeline_name or timeline_name.empty():
		return
	var scene = _find_scene(node)
	if not scene:
		return
	scene.start_dialogue(timeline_name)


func _find_scene(node: Node):
	var parent = node.get_parent() as Node
	while parent:
		if parent.has_method("start_dialogue"):
			return parent
		parent = parent.get_parent() as Node
	return null
