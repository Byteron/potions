extends Area3D
class_name Interacter

@onready var _character: Character = get_parent()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()


func _process(delta: float) -> void:
	if Input.is_action_pressed("refine"):
		refine()
		if _character.anim.current_animation != "refine":
			_character.anim.play("refine")
	if Input.is_action_just_released("refine"):
		_character.anim.play("normal")

func interact() -> void:
	for area in get_overlapping_areas():
		if area is Interactable:
			area.interact(_character)
			return


func refine() -> void:
	for area in get_overlapping_areas():
		if area is Refiner:
			area.refine()
			return
