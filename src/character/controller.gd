extends Node
class_name Controller

@onready var parent: CharacterBody3D = get_parent()
@export var speed := 8


func _process(delta: float) -> void:
	parent.velocity = get_direction() * speed

	if parent.velocity != Vector3.ZERO:
		parent.look_at(parent.position + parent.velocity, Vector3.UP)

	parent.move_and_slide()


func get_direction() -> Vector3:
	var direction := Vector3()
	direction.x = Input.get_axis("move_left", "move_right")
	direction.z = Input.get_axis("move_up", "move_down")
	return direction.normalized()
