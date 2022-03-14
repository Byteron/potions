extends CanvasLayer
class_name HUD

@export var RecipeEntry: PackedScene = null

@onready var score_label: Label = $ScoreLabel
@onready var container: Control = $VBoxContainer


func _ready() -> void:
	for recipe in Recipes.recipes:
		var entry = RecipeEntry.instantiate()
		entry.recipe = recipe
		container.add_child(entry)


func _process(delta: float) -> void:
	score_label.text = "Score: " + str(Recipes.score)
