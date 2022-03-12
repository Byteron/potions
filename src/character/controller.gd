extends Node
class_name Controller

@onready var parent := get_parent()
@export var speed := 2


func _process(delta: float) -> void:
	parent.position += get_direction() * speed * delta


func get_direction() -> Vector3:
	var direction := Vector3()
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.z = Input.get_axis("ui_up", "ui_down")
	return direction.normalized()
