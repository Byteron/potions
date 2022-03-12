extends Area3D
class_name Picker

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		pick()


func pick() -> void:
	for area in get_overlapping_areas():
		if area is Pickable:
			area.pick()
			return
