extends Area3D
class_name Pickable

signal picked()


func pick() -> void:
	picked.emit()
	print("picked")
