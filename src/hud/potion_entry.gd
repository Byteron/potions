extends Control
class_name PotionEntry

@onready var label: Label = $HBoxContainer/Label
@onready var container: Control = $HBoxContainer/HBoxContainer

var order: Order = null


func _ready() -> void:
	for ingredient in order.recipe.ingredients:
		var rect = TextureRect.new()
		rect.ignore_texture_size = true
		rect.rect_min_size = Vector2(32, 32)
		rect.texture = ingredient.texture
		container.add_child(rect)


func _process(_delta: float) -> void:
	label.text = str(int(order.timer.time_left))
