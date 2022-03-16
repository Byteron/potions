extends Resource
class_name RecipeIngredient

@export var plant : Ingredient.PlantType = Ingredient.PlantType.HERB
@export var refinement: Ingredient.RefinementType = Ingredient.RefinementType.NONE
@export var texture: Texture = null


func stringify() -> String:
	return str(plant) + " " + str(refinement)
