extends Node2D

var game_started = false

onready var _scene_container := $SceneContainer
onready var _vignette := $VignetteLayer/Vignette
onready var _ui_layer := $UILayer


func _input(event):
	if game_started and not get_tree().paused and Input.is_action_just_pressed("ui_cancel"):
		pause_game()


func enable_fullscreen():
	OS.window_fullscreen = true
	OS.window_borderless = true


func disable_fullscreen():
	OS.window_fullscreen = false
	OS.window_borderless = false
	OS.window_size = Vector2(1280.0, 720.0)
	OS.center_window()


func enable_vignette():
	_vignette.visible = true


func disable_vignette():
	_vignette.visible = false


func pause_game():
	switch_ui("res://pause/pause.tscn")
	get_tree().paused = true


func unpause_game():
	get_tree().paused = false


func switch_ui(path: String):
	var scene = load(path) as PackedScene
	switch_ui_to(scene)


func switch_ui_to(scene: PackedScene):
	if _ui_layer.get_child_count() > 0:
		var child = _ui_layer.get_child(0)
		if child:
			child.queue_free()
	_ui_layer.add_child(scene.instance())


func switch_scene(path: String):
	var scene = load(path) as PackedScene
	switch_scene_to(scene)


func switch_scene_to(scene: PackedScene):
	if _scene_container.get_child_count() > 0:
		var child = _scene_container.get_child(0)
		if child:
			child.queue_free()
	_scene_container.add_child(scene.instance())
