extends Node3D
class_name CuttingBoard

var _ingredient: Ingredient = null

@onready var _container: Position3D = $Container


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Ingredient and not has_ingredient():
		_ingredient = character.drop_item()
		_container.add_child(_ingredient)

	elif not character.has_item() and has_ingredient() and _ingredient.is_refined:
		_container.remove_child(_ingredient)
		character.take_item(_ingredient)
		_ingredient = null


func has_ingredient() -> bool:
	return _ingredient != null


func _on_refiner_refined() -> void:
	if not has_ingredient():
		return
	
	_ingredient.refine(Ingredient.RefinementType.CUT)
