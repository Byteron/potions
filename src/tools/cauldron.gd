extends Node3D
class_name Cauldron

const BREWING_TIME_PER_INGREDIENT := 2.5
const BREWING_TIME := 5.0

var _ingredients: Array[Ingredient] = []

var brewing_time := 0.0
var brewed_time := 0.0
var is_brewed := false

@onready var particles: CPUParticles3D = $BrewingParticles
@onready var done_particles: CPUParticles3D = $BrewDoneParticles

@onready var liquid: Node3D = $cauldron/Cauldron
@onready var light: SpotLight3D = $SpotLight3D

@onready var fill_bottle_player: AudioStreamPlayer3D = $FillBottlePlayer
@onready var add_ingredient_player: AudioStreamPlayer3D = $AddIngredientPlayer
@onready var brewing_player: AudioStreamPlayer3D = $BrewingPlayer
@onready var brew_done_player: AudioStreamPlayer3D = $BrewDonePlayer


func _process(delta: float) -> void:
	if _ingredients.is_empty():
		return
	
	if brewed_time < brewing_time:
		particles.emitting = true
		brewed_time += delta
		if not brewing_player.playing:
			brewing_player.play()
	
	if brewed_time > brewing_time and not is_brewed:
		is_brewed = true
		particles.emitting = false
		done_particles.emitting = true
		brewing_player.stop()
		brew_done_player.play()


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Ingredient:
		var ingredient = character.drop_item()
		_ingredients.append(ingredient)
		brewing_time = BREWING_TIME + BREWING_TIME_PER_INGREDIENT * _ingredients.size()
		is_brewed = false
		liquid.visible = true
		add_ingredient_player.play()
		update_color()

	elif character.has_item()  and character.item is Bottle and is_brewed:
		var bottle: Bottle = character.item
		bottle.ingredients = _ingredients
		bottle.is_filled = true
		bottle.update_sprite()
		fill_bottle_player.play()
		_reset()


func update_color() -> void:
	var color = Color.BLACK
	for ingredient in _ingredients:
		color += ingredient.data.color
	color = color / _ingredients.size()
	liquid.material_override.set("albedo_color", color)
	light.light_color = color


func _reset() -> void:
	_ingredients = []
	liquid.visible = false
	brewing_time = BREWING_TIME + BREWING_TIME_PER_INGREDIENT * _ingredients.size()
	brewed_time = 0.0
	is_brewed = false
