extends Node

const SAVE_FILE = "user://save.dat"

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
var current_location = LOCATION.NONE
var game_loaded = false


func _exit_tree():
	save_state()


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


func save_state():
	var f = File.new()
	if f.open(SAVE_FILE, File.WRITE) == OK:
		f.store_var(evidence_found)
		f.store_var(locations_visited)
		f.store_var(state)
		f.store_var(current_location)
		f.store_var(Dialogic.export())
		f.close()


func load_state():
	var f = File.new()
	if f.open(SAVE_FILE, File.READ) == OK:
		evidence_found = f.get_var()
		locations_visited = f.get_var()
		state = f.get_var()
		current_location = f.get_var()
		Dialogic.import(f.get_var())
		f.close()
		game_loaded = true


func has_save_state() -> bool:
	var f = File.new()
	return f.file_exists(SAVE_FILE)
