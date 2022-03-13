extends Node3D
class_name Bin


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item():
		character.drop_item()
