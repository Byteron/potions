extends Area3D
class_name Refiner

signal refined()
signal finished()


func refine() -> void:
	refined.emit()


func finish() -> void:
	finished.emit()
