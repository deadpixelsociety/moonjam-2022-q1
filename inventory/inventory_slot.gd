tool
extends Control
class_name InventorySlot

export(Resource) var clue setget _set_clue, _get_clue

var clue_name = ""
var description = ""

onready var _texture := $Texture


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
	
	if _texture:
		_texture.texture = c.texture
		_texture.self_modulate = c.tint
	
	hint_tooltip = c.description
	clue_name = c.clue_name
	description = c.description
