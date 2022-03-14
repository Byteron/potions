extends Node3D
class_name BottleBag

@export var Bottle: PackedScene = null


func _on_interactable_interacted(character: Character) -> void:
	if not character.has_item():
		var bottle: Bottle = Bottle.instantiate()
		character.take_item(bottle)
