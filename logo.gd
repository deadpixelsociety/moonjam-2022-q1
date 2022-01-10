extends Control
class_name Logo

onready var _logo := $TextureRect


func _ready():
	var anima = Anima.begin(self, "fade_out")
	anima.wait(3.0)
	anima.then({
		node = _logo,
		property = "modulate:a",
		animation = "fade_out",
		duration = 4.0
	})
	anima.play()
	yield(anima, "animation_completed")
	Main.switch_ui("res://title/title_screen.tscn")
