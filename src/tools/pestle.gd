extends Node3D
class_name Pestle

const REFINE_TIME := 1.0

var _ingredient: Ingredient = null

var refine_progress := 0.0


@onready var _container: Position3D = $Container
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D


func _on_interactable_interacted(character: Character) -> void:
	refine_progress = 0

	if character.has_item() and character.item is Ingredient and character.item.refinement == Ingredient.RefinementType.DRIED and not has_ingredient():
		_ingredient = character.drop_item()
		_ingredient.is_refined = false
		_container.add_child(_ingredient)

	elif not character.has_item() and has_ingredient():
		_container.remove_child(_ingredient)
		character.take_item(_ingredient)
		_ingredient.is_refined = true
		_ingredient = null


func has_ingredient() -> bool:
	return _ingredient != null


func _on_refiner_refined() -> void:
	if not has_ingredient():
		return
	
	if _ingredient.is_refined:
		return

	if not audio_player.playing:
		audio_player.play()
	
	refine_progress += get_process_delta_time()

	if refine_progress > REFINE_TIME:
		_ingredient.refine(Ingredient.RefinementType.GROUND)
		audio_player.stop()

func _on_refiner_finished() -> void:
	audio_player.stop()
