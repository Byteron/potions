extends HBoxContainer

@onready var label: Label = $Label
@onready var container: Control = $HBoxContainer

var recipe: Recipe = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = recipe.name
	
	for ingredient in recipe.ingredients:
		var rect = TextureRect.new()
		rect.ignore_texture_size = true
		rect.rect_min_size = Vector2(32, 32)
		rect.texture = ingredient.texture
		container.add_child(rect)
