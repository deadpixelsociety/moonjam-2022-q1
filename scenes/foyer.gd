extends Scene
class_name Foyer

var _go_grounds = false


func start_dialogue(timeline_name: String):
	_hide_characters()
	.start_dialogue(timeline_name)


func _on_Foyer_scene_ready():
	if GameState.is_at_least_state(GameState.STATE.FIND_GROUNDS):
		_show_characters()
	else:
		var dialogue = _get_dialogue()
		if not dialogue or dialogue.empty():
			return
		var dialogic = Dialogic.start(dialogue)
		dialogic.connect("timeline_end", self, "_on_timeline_end")
		get_tree().root.call_deferred("add_child", dialogic)


func _on_timeline_end(timeline_name: String):
	if GameState.is_state(GameState.STATE.ROOM_INTRO):
		goto_scene("res://scenes/kitchen.tscn")
	if GameState.is_state(GameState.STATE.MET_HENRY):
		GameState.state = GameState.STATE.FIND_GROUNDS
	if GameState.is_state(GameState.STATE.FIND_GROUNDS) and _go_grounds:
		goto_scene("res://scenes/confession.tscn")
	._on_timeline_end(timeline_name)


func _get_dialogue() -> String:
	if GameState.is_state(GameState.STATE.ROOM_INTRO):
		return "foyer-1"
	elif GameState.is_state(GameState.STATE.MET_HENRY):
		return "foyer-2"
	return ""


func _on_GoKitchen_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		start_dialogue("foyer-2-go-kitchen")


func _on_GoUpstairs_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		start_dialogue("foyer-2-go-upstairs")


func _on_GoFront_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		start_dialogue("foyer-2-go-front")


func _on_GoGrounds_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		_go_grounds = true
		start_dialogue("foyer-2-go-grounds")


