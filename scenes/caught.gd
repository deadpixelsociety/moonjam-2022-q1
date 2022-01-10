extends Scene
class_name Caught


func _ready():
	Audio.play_investigation_theme()


func _on_Caught_scene_ready():
	start_dialogue("caught")


func _on_timeline_end(timeline_name: String):
	._on_timeline_end(timeline_name)
	match GameState.state:
		GameState.STATE.CAUGHT:
			GameState.state = GameState.STATE.FINALE
			start_dialogue("finale")
		GameState.STATE.FINALE:
			yield(fade_out(), "completed")
			Main.switch_ui("res://end.tscn")
			queue_free()
