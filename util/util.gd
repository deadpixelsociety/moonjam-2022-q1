extends Node


func null_or_empty(str_value) -> bool:
	if not str_value is String:
		return true
	return not str_value or str_value.empty()


func wait(node: Node, wait_time: float) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.autostart = true
	timer.connect("timeout", self, "_on_wait_timeout", [ timer ])
	node.call_deferred("add_child", timer)
	return timer


func _on_wait_timeout(timer: Timer):
	if timer:
		timer.queue_free()
