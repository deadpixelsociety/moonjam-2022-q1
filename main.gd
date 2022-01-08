extends Control

onready var _scene_viewport := $ViewportContainer/SceneViewport


func enable_fullscreen():
	OS.window_fullscreen = true
	OS.window_borderless = true


func disable_fullscreen():
	OS.window_fullscreen = false
	OS.window_borderless = false
	OS.center_window()


func switch_scene(path: String):
	var scene = load(path) as PackedScene
	switch_scene_to(scene)


func switch_scene_to(scene: PackedScene):
	if _scene_viewport.get_child_count() > 0:
		var child = _scene_viewport.get_child(0)
		if child:
			child.queue_free()
	_scene_viewport.add_child(scene.instance())
