extends Node
class_name Order

signal expired(order: Order)
signal finished(order: Order)

var recipe: Recipe

@onready var timer: Timer = $Timer


func finish() -> void:
	finished.emit(self)


func get_time_left_modifier() -> float:
	return timer.time_left / 20.0


func _on_timer_timeout() -> void:
	expired.emit(self)
	queue_free()