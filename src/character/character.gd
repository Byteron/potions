extends CharacterBody3D
class_name Character

@export var speed := 8


func _process(delta: float) -> void:
	velocity = get_direction() * speed

	if velocity != Vector3.ZERO:
		look_at(position + velocity, Vector3.UP)

	move_and_slide()


func get_direction() -> Vector3:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_direction.x, 0, input_direction.y).normalized()
	return direction
