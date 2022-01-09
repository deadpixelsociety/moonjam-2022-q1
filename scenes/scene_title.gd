tool
extends Control
class_name SceneTitle

export(String) var title setget _set_title, _get_title
export(float) var title_pause = 2.0

onready var _background := $ColorRect
onready var _label := $Label


func _ready():
	_apply_title()


func transition():
	yield(transition_in(), "completed")
	yield(Util.wait(self, title_pause), "timeout")
	return yield(transition_out(), "completed")


func transition_in():
	self_modulate.a = 0.0
	_label.self_modulate.a = 0.0
	visible = true
	var anima = Anima.begin(self, "transition_in")
	anima.then({
		node = self,
		easing = AnimaEasing.EASING.EASE_OUT_CIRC,
		property = "rect_size:x",
		from = 0.0,
		to = 1280.0,
		duration = 1.0
	})
	anima.with({
		node = self, 
		property = "modulate:a",
		animation = "fade_in",
		duration = 1.0
	})
	anima.then({
		node = _label,
		property = "self_modulate:a",
		animation = "fade_in",
		duration = 1.5
	})
	anima.play()
	return yield(anima, "animation_completed")


func transition_out():
	var anima = Anima.begin(self, "transition_out")
	anima.then({
		node = _label,
		property = "self_modulate:a",
		animation = "fade_out",
		duration = 1.5
	})
	anima.then({
		node = self,
		easing = AnimaEasing.EASING.EASE_OUT_CIRC,
		property = "rect_size:x",
		from = 1280.0,
		to = 0.0,
		duration = 1.0
	})
	anima.with({
		node = self, 
		property = "modulate:a",
		animation = "fade_out",
		duration = 1.0
	})
	anima.play()
	return yield(anima, "animation_completed")


func _set_title(value: String):
	title = value
	_apply_title()


func _get_title() -> String:
	return title


func _apply_title():
	if _label:
		_label.text = title
