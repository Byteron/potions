extends Node3D
class_name DryingHook

const DRYING_TIME := 8.0

var _ingredient: Ingredient = null

@onready var _container: Position3D = $Container


func _process(delta: float) -> void:
	if _ingredient == null:
		return
	
	_ingredient.refine(Ingredient.RefinementType.CUT)


func has_ingredient() -> bool:
	return _ingredient != null


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Ingredient and not has_ingredient():
		_ingredient = character.drop_item()
		_container.add_child(_ingredient)

	elif not character.has_item() and has_ingredient():
		_container.remove_child(_ingredient)
		character.take_item(_ingredient)
		_ingredient = null
