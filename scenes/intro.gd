extends Scene
class_name Intro


func _ready():
	GameState.state = GameState.STATE.ROOM_INTRO


func _on_Intro_scene_ready():
	var dialogic = Dialogic.start("intro")
	dialogic.connect("timeline_end", self, "_on_timeline_end")
	get_tree().root.call_deferred("add_child", dialogic)


func _on_timeline_end(timeline_name: String):
	goto_scene("res://scenes/manor_front.tscn")
