extends Node
class_name Controller

@onready var parent := get_parent()
@export var speed := 8


func _process(delta: float) -> void:
	var next_position: Vector3 = parent.position + get_direction() * speed * delta
	
	if next_position == parent.position:
		return

	parent.look_at(next_position, Vector3.UP)
	parent.position = next_position


func get_direction() -> Vector3:
	var direction := Vector3()
	direction.x = Input.get_axis("move_left", "move_right")
	direction.z = Input.get_axis("move_up", "move_down")
	return direction.normalized()
