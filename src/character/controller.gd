extends Node

@export var _speed := 8

@onready var character: Character = get_parent()

var boost := 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") and boost == 1.0:
		boost = 2.6


func _process(_delta: float) -> void:
	character.velocity = get_direction() * _speed * boost
	
	boost = lerp(boost, 1.0, 0.075)
	boost = 1.0 if boost < 1.1 else boost

	if character.velocity != Vector3.ZERO:
		character.look_at(character.position + character.velocity, Vector3.UP)

	character.move_and_slide()


func get_direction() -> Vector3:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_direction.x, 0, input_direction.y)
	return direction
