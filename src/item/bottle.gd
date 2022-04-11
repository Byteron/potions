extends Item
class_name Bottle

@export var empty_texture: Texture = null
@export var filled_texture: Texture = null

var ingredients: Array[Ingredient] = []

var is_filled := false


func update_sprite() -> void:
	if is_filled:
		_sprite.texture = filled_texture
		update_color()
	else:
		_sprite.modulate = Color.WHITE
		_sprite.texture = empty_texture


func update_color() -> void:
	var color = Color.BLACK
	for ingredient in ingredients:
		color += ingredient.data.color
	color = color / ingredients.size()
	_sprite.modulate = color


func stringify() -> String:
	var s = "Bottle: "
	for ingredient in ingredients:
		s += "\n" + ingredient.stringify()
	return s
