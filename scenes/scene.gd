extends Node2D
class_name Scene

signal scene_ready()

export(GameState.LOCATION) var location = 0
export(bool) var show_map = true
export(bool) var show_leave = true

var _leaving = false
var _locations_visible = false
var _map_visible = false
var _interacting = false

onready var _characters := $Layers/MiddleObjects/Characters
onready var _interactables := $Layers/MiddleObjects/Interactables
onready var _leave_button := $Overlay/OverlayContainer/Buttons/Leave
onready var _location_list := $Overlay/OverlayContainer/LocationList
onready var _map_button := $Overlay/OverlayContainer/Buttons/Map
onready var _minimap := $Overlay/OverlayContainer/Minimap
onready var _title := $Overlay/OverlayContainer/SceneTitle


func _ready():
	disable_interactables()
	if not GameState.visited_location(location):
		yield(fade_in(), "completed")
		yield(_title.transition(), "completed")
	else:
		yield(fade_in(), "completed")

	# After the first Kitchen player can see the map
	if GameState.is_at_least_state(GameState.STATE.FIND_GROUNDS):
		show_map_button()
		show_leave_button()
	else:
		hide_map_button()
		hide_leave_button()
		
	GameState.set_location_visited(location)
	GameState.current_location = location
	EventBus.publish("location_changed", location)
	EventBus.subscribe("interactable_clicked", self, "_on_interactable_clicked")

	enable_interactables()
	emit_signal("scene_ready")


func _exit_tree():
	EventBus.unsubscribe("interactable_clicked", self)


func start_dialogue(timeline_name: String):
	hide_map_button()
	hide_leave_button()
	_hide_map()
	_hide_locations()
	disable_interactables()
	var dialogic = Dialogic.start(timeline_name)
	dialogic.connect("timeline_end", self, "_on_timeline_end")
	get_tree().root.call_deferred("add_child", dialogic)


func goto_scene(scene: String):
	hide_leave_button()
	hide_map_button()
	_hide_characters()
	_hide_locations()
	_hide_map()
	yield(fade_out(), "completed")
	Main.switch_scene(scene)


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


func show_leave_button():
	if show_leave:
		_leave_button.show()


func hide_leave_button():
	_leave_button.hide()


func _show_locations():
	_locations_visible = true
	var anima = Anima.begin(self, "show_location")
	anima.then({
		node = _location_list,
		property = "modulate:a",
		from = 0.0,
		to = 1.0,
		duration = 0.5
	})
	anima.with({
		node = _location_list,
		property = "rect_scale",
		from = Vector2.ZERO,
		to = Vector2.ONE,
		duration = 0.5
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()


func _hide_locations():
	_locations_visible = false
	var anima = Anima.begin(self, "hide_locations")
	anima.then({
		node = _location_list,
		property = "modulate:a",
		from = 1.0,
		to = 0.0,
		duration = 0.5
	})
	anima.with({
		node = _location_list,
		property = "rect_scale",
		from = Vector2.ONE,
		to = Vector2.ZERO,
		duration = 0.5
	})
	anima.play()
	yield(anima, "animation_completed")
	_location_list.visible = false


func show_map_button():
	if show_map:
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


func enable_interactables():
	if GameState.is_at_least_state(GameState.STATE.FIND_EVIDENCE):
		_interactables.visible = true


func disable_interactables():
	_interactables.visible = false


func _show_characters():
	if _characters.visible:
		return
	var anima = Anima.begin(self, "show_characters")
	anima.then({
		node = _characters, 
		property = "modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
	yield(anima, "animation_completed")
	for child in _characters.get_children():
		var character = child as SceneCharacterPlacement
		if character:
			character.monitoring = true
			character.input_pickable = true


func _hide_characters():
	if not _characters.visible:
		return
	
	for child in _characters.get_children():
		var character = child as SceneCharacterPlacement
		if character:
			character.monitoring = false
			character.input_pickable = false
		
	var anima = Anima.begin(self, "hide_characters")
	anima.then({
		node = _characters, 
		property = "modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	yield(anima, "animation_completed")
	_characters.visible = false


func _on_Leave_pressed():
	if _locations_visible:
		_leaving = false
		_hide_locations()
		show_map_button()
		_show_characters()
		enable_interactables()
	else:
		_leaving = true
		_show_locations()
		hide_map_button()
		_hide_characters()
		_hide_map()
		disable_interactables()


func _on_Map_pressed():
	if _map_visible:
		_hide_map()
		show_leave_button()
		_show_characters()
		enable_interactables()
	else:
		_show_map()
		hide_leave_button()
		_hide_characters()
		_hide_locations()
		disable_interactables()


func _on_timeline_end(timeline: String):
	if not _leaving and GameState.is_at_least_state(GameState.STATE.MET_HENRY):
		enable_interactables()
		show_map_button()
		show_leave_button()
		_show_characters()
		_interacting = false


func _on_interactable_clicked(interactable: InteractableObject):
	_interacting = true
	hide_leave_button()
	hide_map_button()
	_hide_map()
	_hide_characters()
	_hide_locations()
