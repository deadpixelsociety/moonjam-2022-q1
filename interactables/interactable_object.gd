tool
extends Area2D
class_name InteractableObject

export(Resource) var interactable setget _set_interactable, _get_interactable
export(float) var highlight_rate = 1.0

var interactable_name = ""
var description = ""
var tint = Color.white

var _highlighted = false
var _highlight_timer = highlight_rate
var _highlight_dir = -1.0

onready var _sprite := $Sprite
onready var _tooltip := $Tooltip


func _ready():
	_apply_interactable()


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


func _set_interactable(value: Resource):
	interactable = value
	_apply_interactable()


func _get_interactable() -> Resource:
	return interactable


func _apply_interactable():
	var c = interactable as Interactable
	if not c:
		return
	if _sprite:
		_sprite.texture = c.texture
	if _tooltip:
		_tooltip.text = c.interactable_name
	interactable_name = c.interactable_name
	tint = c.color


func _move_tooltip(pos: Vector2):
	if not _tooltip:
		return
	_tooltip.rect_global_position = pos + Vector2(32.0, 0.0)


func _on_InteractableObject_input_event(viewport, event, shape_idx):
	if _highlighted and event is InputEventMouseMotion:
		_move_tooltip(get_global_mouse_position())
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var c = interactable as Interactable
			if c:
				EventBus.publish("interactable_clicked", self)
				c.interact(self)


func _on_InteractableObject_mouse_entered():
	_highlighted = true
	var anima = Anima.begin(self, "show_tooltip")
	_tooltip.self_modulate.a = 0.0
	_tooltip.visible = true
	anima.then({ node = _tooltip, animation = "fade_in", property = "self_modulate:a", duration = 0.3 })
	anima.play()


func _on_InteractableObject_mouse_exited():
	_highlighted = false
	modulate = Color.white
	var anima = Anima.begin(self, "hide_tooltip")
	anima.then({ node = _tooltip, animation = "fade_out", property = "self_modulate:a", duration = 0.1 })
	anima.play()
	yield(anima, "animation_completed")
	_tooltip.visible = false
