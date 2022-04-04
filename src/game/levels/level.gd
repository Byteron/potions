extends Node3D
class_name Level

@export var game_time := 240.0
@export var difficulty: Resource = null


func _ready() -> void:
	Recipes.difficulty = difficulty as Difficulty
