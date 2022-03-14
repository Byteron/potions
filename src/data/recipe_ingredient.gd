extends Resource
class_name RecipeIngredient

@export var name := ""
@export var refinement: Ingredient.RefinementType = Ingredient.RefinementType.NONE
@export var texture: Texture = null


func stringify() -> String:
	return name + " " + str(refinement)
