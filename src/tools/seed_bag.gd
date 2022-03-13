extends Node3D
class_name SeedBag

@export var Seed: PackedScene = null


func _on_interactable_interacted(character: Character) -> void:
	if not character.has_item():
		var seed: Seed = Seed.instantiate()
		character.take_item(seed)
