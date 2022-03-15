extends Item
class_name Bottle

@export var empty_texture: Texture = null
@export var filled_texture: Texture = null

var ingredients: Array[Ingredient] = []

var is_filled := false


func update_sprite() -> void:
	if is_filled:
		_sprite.texture = filled_texture
	else:
		_sprite.texture = empty_texture


func has_ingredient(recipe_ingredient: RecipeIngredient) -> bool:
	var has := false
	for ingredient in ingredients:
		var same_name = ingredient.data.name == recipe_ingredient.name
		var same_refinement = ingredient.refinement == recipe_ingredient.refinement
		# print(ingredient.data.name, recipe_ingredient.name, same_name, ingredient.refinement, recipe_ingredient.refinement, same_refinement)
		if same_name and same_refinement:
			has = true

	return has


func stringify() -> String:
	var s = "Bottle: "
	for ingredient in ingredients:
		s += "\n" + ingredient.stringify()
	return s
