extends Node2D
class_name Scene

signal scene_ready()

export(GameState.LOCATION) var location = 0

var _map_visible = false

onready var _map_button := $Overlay/OverlayContainer/Map
onready var _minimap := $Overlay/OverlayContainer/Minimap
onready var _title := $Overlay/OverlayContainer/SceneTitle


func _ready():
	if not GameState.visited_location(location):
		yield(fade_in(), "completed")
		yield(_title.transition(), "completed")
		emit_signal("scene_ready")
	else:
		yield(fade_in(), "completed")
		emit_signal("scene_ready")
	
	# After the first Kitchen player can see the map
	if GameState.visited_location(GameState.LOCATION.KITCHEN):
		show_map_button()
	else:
		hide_map_button()
		
	GameState.set_location_visited(location)
	EventBus.publish("location_changed", location)


func start_dialogue(timeline_name: String):
	hide_map_button()
	var dialogic = Dialogic.start(timeline_name)
	dialogic.connect("timeline_end", self, "_on_timeline_end")
	get_tree().root.call_deferred("add_child", dialogic)


func fade_in():
	var anima = Anima.begin(self, "fade_to_white")
	anima.then({ 
		node = $Layers, 
		easing = AnimaEasing.EASING.EASE_OUT_CIRC,
		property = "modulate", 
		from = Color.black, 
		to = Color.white, 
		duration = 2.0 
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	return yield(anima, "animation_completed")


func fade_out():
	var anima = Anima.begin(self, "fade_to_black")
	anima.then({ 
		node = $Layers, 
		property = "modulate", 
		from = Color.white, 
		to = Color.black, 
		duration = 2.0 
	})
	anima.play()
	return yield(anima, "animation_completed")


func show_map_button():
	_map_button.show()


func hide_map_button():
	_map_button.hide()


func _show_map():
	_map_visible = true
	var anima = Anima.begin(self, "show_map")
	anima.then({
		node = _minimap,
		property = "modulate:a",
		from = 0.0,
		to = 1.0,
		duration = 0.5
	})
	anima.with({
		node = _minimap,
		property = "rect_scale",
		from = Vector2.ZERO,
		to = Vector2.ONE,
		duration = 0.5
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()


func _hide_map():
	_map_visible = false
	var anima = Anima.begin(self, "hide_map")
	anima.then({
		node = _minimap,
		property = "modulate:a",
		from = 1.0,
		to = 0.0,
		duration = 0.5
	})
	anima.with({
		node = _minimap,
		property = "rect_scale",
		from = Vector2.ONE,
		to = Vector2.ZERO,
		duration = 0.5
	})
	anima.play()
	yield(anima, "animation_completed")
	_minimap.visible = false


func _on_Map_pressed():
	if _map_visible:
		_hide_map()
	else:
		_show_map()


func _on_timeline_end(timeline: String):
	pass
