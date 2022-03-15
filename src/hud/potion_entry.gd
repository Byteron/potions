extends Control
class_name PotionEntry

@onready var label: Label = $HBoxContainer/Label
@onready var container: Control = $HBoxContainer/HBoxContainer

var recipe: Recipe = null


func update_info() -> void:
	label.text = recipe.name

	for ingredient in recipe.ingredients:
		var rect = TextureRect.new()
		rect.ignore_texture_size = true
		rect.rect_min_size = Vector2(32, 32)
		rect.texture = ingredient.texture
		container.add_child(rect)

