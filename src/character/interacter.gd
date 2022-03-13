extends Area3D
class_name Interacter

@onready var _character: Character = get_parent()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()


func interact() -> void:
	for area in get_overlapping_areas():
		if area is Interactable:
			area.interact(_character)
			return
