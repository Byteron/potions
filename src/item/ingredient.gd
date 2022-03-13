extends Item
class_name Ingredient

enum RefinementType { NONE, CUT, DRIED }

var data: IngredientData = null

var is_refined := false
var refinement := RefinementType.NONE

func _ready() -> void:
	_sprite = $Sprite3D
	update_sprite()


func update_sprite() -> void:
	match refinement:
		RefinementType.NONE:
			_sprite.texture = data.default_texture
		RefinementType.CUT:
			_sprite.texture = data.cut_texture
