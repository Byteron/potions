extends Resource
class_name Recipe

@export var name := ""
@export var ingredients: Array[Resource] = []
@export var score := 100

func stringify() -> String:
	var s = name + ": "
	for ingredient in ingredients:
		s += "\n" + ingredient.name + " " + str(ingredient.refinement)
	return s
