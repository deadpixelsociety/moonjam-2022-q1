extends Node

enum LOCATION {
	NONE,
	OFFICE,
	KITCHEN,
	GROUNDS,
	FOYER,
	DINING_ROOM,
	BATHROOM,
	FRONT
}

var locations_visited = {}

var foyer_dialogue_1 = true
var foyer_dialogue_2 = true
var kitchen_dialogue_1 = true


func set_location_visited(location: int):
	locations_visited[location] = true


func visited_location(location: int):
	return locations_visited.has(location)
