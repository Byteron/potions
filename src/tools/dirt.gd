extends Node3D
class_name Dirt

var _growable: Growable = null

@export var Growable: PackedScene = null
@export var Ingredient: PackedScene = null

@onready var _container: Position3D = $Container

@onready var plant_player: AudioStreamPlayer3D = $PlantPlayer
@onready var harvest_player: AudioStreamPlayer3D = $HarvestPlayer


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Seed and not has_growable():
		var carried_seed: Seed = character.item
		_growable = Growable.instantiate()
		_growable.data = carried_seed.data as GrowableData
		_container.add_child(_growable)
		var item = character.drop_item()
		item.queue_free()
		plant_player.play()

	elif not character.has_item() and has_growable() and _growable.is_grown:
		var ingredient = Ingredient.instantiate()
		ingredient.data = _growable.data.ingredient_data as IngredientData
		character.take_item(ingredient)
		harvest_player.play()

		_growable.pick()
		
		if _growable.amount == 0:
			_growable.queue_free()
			_growable = null
		else:
			_growable.animate(0.9)


func has_growable() -> bool:
	return _growable != null
