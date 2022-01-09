extends Scene
class_name Confession


func _on_Confession_scene_ready():
	var dialogic = Dialogic.start("confession")
	dialogic.connect("timeline_end", self, "_on_timeline_end")
	get_tree().root.call_deferred("add_child", dialogic)


func _on_timeline_end(timeline_name: String):
	goto_scene("res://scenes/grounds.tscn")
