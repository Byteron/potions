extends Node

@export var _speed := 8

@onready var character: Character = get_parent()


func _process(_delta: float) -> void:
	character.velocity = get_direction() * _speed

	if character.velocity != Vector3.ZERO:
		character.look_at(character.position + character.velocity, Vector3.UP)

	character.move_and_slide()


func get_direction() -> Vector3:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_direction.x, 0, input_direction.y).normalized()
	return direction
