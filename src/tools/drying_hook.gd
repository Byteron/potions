extends Node3D
class_name DryingHook

const REFINE_TIME := 8.0

var _ingredient: Ingredient = null

var refine_progress := 0.0

@onready var _container: Position3D = $Container


func _process(_delta: float) -> void:
	if not has_ingredient():
		return
	
	if _ingredient.is_refined:
		return
	
	refine_progress += get_process_delta_time()

	if refine_progress > REFINE_TIME:
		_ingredient.refine(Ingredient.RefinementType.DRIED)


func has_ingredient() -> bool:
	return _ingredient != null


func _on_interactable_interacted(character: Character) -> void:
	refine_progress = 0.0
	
	if character.has_item() and character.item is Ingredient and not character.item.is_refined and not has_ingredient():
		_ingredient = character.drop_item()
		_container.add_child(_ingredient)

	elif not character.has_item() and has_ingredient():
		_container.remove_child(_ingredient)
		character.take_item(_ingredient)
		_ingredient = null
