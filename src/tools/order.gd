extends Node
class_name Order

signal expired(order: Order)
signal finished(order: Order)

var recipe: Recipe

@onready var timer: Timer = $Timer


func finish() -> void:
	finished.emit(self)


func get_time_left_modifier() -> float:
	return 1.0 + timer.time_left / 25.0


func _on_timer_timeout() -> void:
	expired.emit(self)
