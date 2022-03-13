extends Node3D
class_name Seed

@export var Item: PackedScene = null


func _on_interactable_interacted(character: Character) -> void:
	if not character.has_item():
		character.take_item(Item.instantiate())
