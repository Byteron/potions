extends Node
class_name Order

signal expired(order: Order)
signal finished(order: Order, position: Vector3)

var recipe: Recipe

var time_step := 1.0

@onready var timer: Timer = $Timer


func start(time: float) -> void:
	timer.start(time)
	time_step = time / 4.0


func finish(position: Vector3) -> void:
	finished.emit(self, position)


func get_time_left_modifier() -> float:
	return 1.0 + timer.time_left / time_step


func _on_timer_timeout() -> void:
	expired.emit(self)
