extends Node3D
class_name Brew

const BREWING_TIME_PER_INGREDIENT := 4.0

var _ingredients: Array[Ingredient] = []

var brewing_time := 0.0
var brewed_time := 0.0
var is_brewed := false

@onready var particles: GPUParticles3D = $GPUParticles3D

@onready var cauldron: Node3D = $cauldron
@onready var cauldron_empty: Node3D = $cauldron_empty


func _process(delta: float) -> void:
	if _ingredients.is_empty():
		return
	
	if brewed_time < brewing_time:
		particles.emitting = true
		brewed_time += delta
	
	if not _ingredients.is_empty() and brewed_time > brewing_time:
		is_brewed = true
		particles.emitting = false


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Ingredient:
		var ingredient = character.drop_item()
		_ingredients.append(ingredient)
		brewing_time = BREWING_TIME_PER_INGREDIENT * _ingredients.size()
		cauldron.visible = true
		cauldron_empty.visible = false

	elif character.has_item()  and character.item is Bottle and is_brewed:
		var bottle: Bottle = character.item
		bottle.ingredients = _ingredients
		bottle.is_filled = true
		bottle.update_sprite()
		_reset()


func _reset() -> void:
	_ingredients = []
	cauldron.visible = false
	cauldron_empty.visible = true
	brewing_time = BREWING_TIME_PER_INGREDIENT * _ingredients.size()
	brewed_time = 0.0
	is_brewed = false
