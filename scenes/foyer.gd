extends Scene
class_name Foyer

var _go_grounds = false

onready var _kitchen := $Overlay/OverlayContainer/LocationList/GoKitchen
onready var _upstairs := $Overlay/OverlayContainer/LocationList/GoUpstairs
onready var _front := $Overlay/OverlayContainer/LocationList/GoFront
onready var _grounds := $Overlay/OverlayContainer/LocationList/GoGrounds
onready var _chugs := $Layers/MiddleObjects/Characters/Chugs


func _on_Foyer_scene_ready():
	if GameState.is_at_least_state(GameState.STATE.FIND_GROUNDS):
		_chugs.visible = GameState.is_state(GameState.STATE.TIME_TO_LEAVE)
		_show_characters()
	
	if GameState.is_at_least_state(GameState.STATE.TIME_TO_LEAVE):
		_kitchen.hide()
		_upstairs.hide()
		_grounds.hide()
		
	var dialogue = _get_dialogue()
	if not dialogue or dialogue.empty():
		return
	start_dialogue(dialogue)


func _on_timeline_end(timeline_name: String):
	._on_timeline_end(timeline_name)
	match GameState.state:
		GameState.STATE.ROOM_INTRO:
			goto_scene("res://scenes/kitchen.tscn")
		GameState.STATE.MET_HENRY:
			GameState.state = GameState.STATE.FIND_GROUNDS
		GameState.STATE.FIND_GROUNDS:
			if _go_grounds:
				goto_scene("res://scenes/confession.tscn")
		GameState.STATE.FIND_EVIDENCE:
			goto_scene("res://scenes/office.tscn")
		GameState.STATE.CAUGHT:
			goto_scene("res://scenes/caught.tscn")


func _get_dialogue() -> String:
	match GameState.state:
		GameState.STATE.ROOM_INTRO:
			return "foyer-1"
		GameState.STATE.MET_HENRY:
			return "foyer-2"
		GameState.STATE.FIND_EVIDENCE:
			return "foyer-3"
		GameState.STATE.TIME_TO_LEAVE:
			return "foyer-4"
	return ""


func _on_GoKitchen_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		start_dialogue("foyer-2-go-kitchen")


func _on_GoUpstairs_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		start_dialogue("foyer-2-go-upstairs")


func _on_GoFront_pressed():
	match GameState.state:
		GameState.STATE.FIND_GROUNDS:
			start_dialogue("foyer-2-go-front")
		GameState.STATE.TIME_TO_LEAVE:
			if GameState.are_evidences_found([ GameState.EVIDENCE.SPOKE_WITH_BOOBA, GameState.EVIDENCE.SPOKE_WITH_CHUGS ]):
				GameState.state = GameState.STATE.CAUGHT
				start_dialogue("foyer-4-leaving")
			else:
				_leaving = false
				start_dialogue("foyer-4-finish-speaking")


func _on_GoGrounds_pressed():
	if GameState.is_state(GameState.STATE.FIND_GROUNDS):
		_go_grounds = true
		start_dialogue("foyer-2-go-grounds")


