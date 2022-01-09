tool
extends Area2D
class_name CluePickup

export(Resource) var clue setget _set_clue, _get_clue

var clue_name = ""
var description = ""

onready var _sprite := $Sprite
onready var _tooltip := $Tooltip


func _ready():
	_apply_clue()


func _set_clue(value: Resource):
	clue = value
	_apply_clue()


func _get_clue() -> Resource:
	return clue


func _apply_clue():
	var c = clue as Clue
	if not c:
		return
		
	if c.texture and _sprite:
		_sprite.texture = c.texture
		_sprite.self_modulate = c.tint

	if _tooltip:
		_tooltip.text = c.description

	clue_name = c.clue_name
	description = c.description


func _move_tooltip(pos: Vector2):
	if not _tooltip:
		return
	_tooltip.rect_global_position = pos + Vector2(32.0, 0.0)


func _on_CluePickup_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion:
		_move_tooltip(get_global_mouse_position())


func _on_CluePickup_mouse_entered():
	var anima = Anima.begin(self, "show_tooltip")
	_tooltip.self_modulate.a = 0.0
	_tooltip.visible = true
	anima.with({ node = _sprite, animation = "fade_in", property = "self_modulate", from = _sprite.self_modulate, to = Color.red, duration = 0.3 })
	anima.then({ node = _tooltip, animation = "fade_in", property = "self_modulate:a", duration = 0.3 })
	anima.play()


func _on_CluePickup_mouse_exited():
	var anima = Anima.begin(self, "show_tooltip")
	anima.with({ node = _sprite, animation = "fade_out", property = "self_modulate", from = _sprite.self_modulate, to = clue.tint, duration = 0.1 })
	anima.then({ node = _tooltip, animation = "fade_out", property = "self_modulate:a", duration = 0.1 })
	anima.play()
	yield(anima, "animation_completed")
	_tooltip.visible = false
