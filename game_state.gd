extends Node

enum EVIDENCE {
	TRACKS,
	SCRAP,
	MURDER_WEAPON,
	TRAY,
	GIFT_CARD,
	SPOKE_WITH_CHUGS,
	SPOKE_WITH_BOOBA
}

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

enum STATE {
	ROOM_INTRO,
	MET_HENRY,
	FIND_GROUNDS,
	FIND_EVIDENCE,
	TIME_TO_LEAVE,
	CAUGHT,
	FINALE
}

var evidence_found = {}
var locations_visited = {}
var state = STATE.FIND_EVIDENCE


func set_evidence_found(evidence: int):
	evidence_found[evidence] = true


func set_evidences_found(evidences: Array):
	for evidence in evidences:
		set_evidence_found(int(evidence))


func is_evidence_found(evidence: int):
	return evidence_found.has(evidence)


func are_evidences_found(evidences: Array) -> bool:
	var found = true
	for evidence in evidences:
		found = found and is_evidence_found(evidence)
	return found


func set_location_visited(location: int):
	locations_visited[location] = true


func visited_location(location: int) -> bool:
	return locations_visited.has(location)


func is_state(value: int) -> bool:
	return state == value


func is_at_least_state(value: int) -> bool:
	return state >= value


func is_state_between(min_value: int, max_value: int) -> bool:
	return state >= min_value and state <= max_value
