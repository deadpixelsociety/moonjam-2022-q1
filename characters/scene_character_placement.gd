tool
extends Area2D
class_name SceneCharacterPlacement

export(Resource) var character setget _set_character, _get_character
export(float) var highlight_rate = 1.0

var character_name = ""
var description = ""
var tint = Color.white

var _highlighted = false
var _highlight_timer = highlight_rate
var _highlight_dir = -1.0

onready var _sprite := $Sprite


func _ready():
	_apply_character()


func _process(delta):
	if _highlighted:
		_highlight_timer += delta * _highlight_dir
		if _highlight_timer <= 0.0:
			_highlight_dir = 1.0
			_highlight_timer = 0.0
		elif _highlight_timer >= highlight_rate:
			_highlight_dir = -1.0
			_highlight_timer = highlight_rate
		var h = sin(_highlight_timer / highlight_rate if highlight_rate != 0.0 else 0.0 * PI / 2.0)
		modulate = lerp(tint, Color.white, h)


func _set_character(value: Resource):
	character = value
	_apply_character()


func _get_character() -> Resource:
	return character


func _apply_character():
	var c = character as SceneCharacter
	if not c:
		return
	if _sprite:
		_sprite.texture = c.portrait
	character_name = c.character_name
	description = c.description
	tint = c.color


func _on_SceneCharacterPlacement_mouse_entered():
	_highlighted = true


func _on_SceneCharacterPlacement_mouse_exited():
	_highlighted = false
	modulate = Color.white
