extends Area3D
class_name Interactable

signal interacted(character: Character)


func interact(character: Character) -> void:
	interacted.emit(character)
