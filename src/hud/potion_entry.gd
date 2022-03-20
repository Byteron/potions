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
		var texture = AtlasTexture.new()
		texture.atlas = ingredient.texture
		texture.region = ingredient.texture.get_image().get_used_rect()
		rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		rect.texture = texture
		container.add_child(rect)

