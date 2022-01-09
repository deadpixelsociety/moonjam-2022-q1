extends Scene
class_name Foyer

onready var _characters := $Layers/MiddleObjects/Characters


func _get_dialogue() -> String:
	if not GameState.foyer_dialogue_1:
		GameState.foyer_dialogue_1 = true
		return "foyer-1"
	elif not GameState.foyer_dialogue_2:
		GameState.foyer_dialogue_2 = true
		return "foyer-2"
	return ""


func _on_Foyer_scene_ready():
	if GameState.foyer_dialogue_2:
		_show_characters()
	else:
		var dialogue = _get_dialogue()
		if not dialogue or dialogue.empty():
			return
		var dialogic = Dialogic.start(dialogue)
		dialogic.connect("timeline_end", self, "_on_timeline_end")
		get_tree().root.call_deferred("add_child", dialogic)


func _on_timeline_end(timeline_name: String):
	if not GameState.visited_location(GameState.LOCATION.KITCHEN):
		Main.switch_scene("res://scenes/kitchen.tscn")
	elif GameState.foyer_dialogue_2:
		_show_characters()


func _show_characters():
	var anima = Anima.begin(self, "show_characters")
	anima.then({
		node = _characters, 
		property = "modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.set_visibility_strategy(Anima.VISIBILITY.HIDDEN_AND_TRANSPARENT)
	anima.play()
