extends Sprite
class_name PoliceCar

export(float) var light_time = 1.0

var _light_timer = light_time
var _blue_light_side = true

onready var _blue_light := $BlueLight
onready var _red_light := $RedLight


func _process(delta):
	_light_timer -= delta
	if _light_timer <= 0.0:
		_light_timer += light_time
		_blue_light_side = not _blue_light_side
		if _blue_light_side:
			_blue_light.visible = true
			_red_light.visible = false
		else:
			_blue_light.visible = false
			_red_light.visible = true
		
