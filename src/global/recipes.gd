extends Node

var recipes: Array[Recipe] = [
	load("data/recipes/love_potion.tres") as Recipe,
	load("data/recipes/healing_potion.tres") as Recipe,
]

var score := 0


func _ready() -> void:
	for recipe in recipes:
		print(recipe.name)
