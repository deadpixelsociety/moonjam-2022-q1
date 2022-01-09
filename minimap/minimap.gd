extends Control
class_name Minimap

onready var _office_loc := $OfficeLoc
onready var _kitchen_loc := $KitchenLoc
onready var _grounds_loc := $GroundsLoc
onready var _foyer_loc := $FoyerLoc
onready var _dining_room_loc := $DiningRoomLoc
onready var _bathroom_loc := $BathroomLoc
onready var _front_loc := $FrontLoc


func _ready():
	EventBus.subscribe("location_changed", self, "_on_location_changed")


func _exit_tree():
	EventBus.unsubscribe("location_changed", self)


func set_location(location: int):
	_hide_all()
	match location:
		GameState.LOCATION.OFFICE:
			_office_loc.show()
		GameState.LOCATION.KITCHEN:
			_kitchen_loc.show()
		GameState.LOCATION.GROUNDS:
			_grounds_loc.show()
		GameState.LOCATION.FOYER:
			_foyer_loc.show()
		GameState.LOCATION.DINING_ROOM:
			_dining_room_loc.show()
		GameState.LOCATION.BATHROOM:
			_bathroom_loc.show()
		GameState.LOCATION.FRONT:
			_front_loc.show()


func _hide_all():
	_office_loc.hide()
	_kitchen_loc.hide()
	_grounds_loc.hide()
	_foyer_loc.hide()
	_dining_room_loc.hide()
	_bathroom_loc.hide()
	_front_loc.hide()


func _on_location_changed(location: int):
	set_location(location)
