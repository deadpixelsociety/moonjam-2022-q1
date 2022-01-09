extends Scene
class_name ManorFront


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
	anima.with({
		node = $Camera2D,
		easing = AnimaEasing.EASING.EASE_OUT_CIRC,
		property = "zoom",
		from = Vector2(0.2, 0.2),
		to = Vector2(1.0, 1.0),
		duration = 2.0
	})
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
	anima.with({
		node = $Camera2D,
		easing = AnimaEasing.EASING.EASE_OUT_CIRC,
		property = "zoom",
		from = Vector2(1.0, 1.0),
		to = Vector2(0.1, 0.1),
		duration = 2.0
	})
	anima.play()
	return yield(anima, "animation_completed")


func _on_ManorFront_scene_ready():
	var dialogic = Dialogic.start("manor_front")
	dialogic.connect("timeline_end", self, "_on_timeline_end")
	get_tree().root.call_deferred("add_child", dialogic)


func _on_timeline_end(timeline_name: String):
	yield(fade_out(), "completed")
	Main.switch_scene("res://scenes/foyer.tscn")
