extends Node3D
class_name Counter


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Bottle and character.item.is_filled:
		var bottle = character.drop_item()
		sell_potion(bottle)
		bottle.queue_free()


func sell_potion(bottle: Bottle) -> void:
	print(bottle.stringify())
	if is_valid_potion(bottle):
		Recipes.score += 100 * bottle.ingredients.size()
	print(Recipes.score)


func is_valid_potion(bottle: Bottle) -> bool:
	for recipe in Recipes.recipes:
		print(recipe.stringify())
		if is_potion_of_recipe(bottle, recipe):
			print("potion is ", recipe.name)
			return true
	return false


func is_potion_of_recipe(bottle: Bottle, recipe: Recipe) -> bool:
	if bottle.ingredients.size() != recipe.ingredients.size():
		print("not the same amount of ingredients for ", recipe.name)
		return false
	
	for ingredient in recipe.ingredients:
		if not bottle.has_ingredient(ingredient):
			print("ingredient ", ingredient.stringify(), " not precent in bottle")
			return false

	return true
