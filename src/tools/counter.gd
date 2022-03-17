extends Node3D
class_name Counter


@onready var coin_player: AudioStreamPlayer3D = $CoinPlayer


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Bottle and character.item.is_filled:
		var bottle = character.drop_item()
		sell_potion(bottle)
		bottle.queue_free()


func sell_potion(bottle: Bottle) -> void:
	print(bottle.stringify())
	validate_potion(bottle)


func validate_potion(bottle: Bottle) -> void:
	for order in Recipes.orders:
		print(order.recipe.stringify())
		if is_potion_of_recipe(bottle, order.recipe):
			order.finish()
			coin_player.play()
			print("potion is ", order.recipe.name)
			return


func is_potion_of_recipe(bottle: Bottle, recipe: Recipe) -> bool:
	print("Check Recipe: ", recipe.name)

	if bottle.ingredients.size() != recipe.ingredients.size():
		print("not the same amount of ingredients for ", recipe.name)
		return false
	
	var ingredients = bottle.ingredients.duplicate()
	for ingredient in recipe.ingredients:
		print(ingredients)
		if not has_ingredient(ingredients, ingredient):
			print("ingredient ", ingredient.stringify(), " not precent in bottle")
			return false
	return true


func has_ingredient(ingredients: Array, recipe_ingredient: RecipeIngredient) -> bool:
	var boolean := false
	var matched_ingredient: Ingredient = null

	for ingredient in ingredients:
		var same_name = ingredient.data.plant == recipe_ingredient.plant
		var same_refinement = ingredient.refinement == recipe_ingredient.refinement
		if same_name and same_refinement:
			matched_ingredient = ingredient
			boolean = true
	
	if boolean:
		ingredients.erase(matched_ingredient)

	return boolean
