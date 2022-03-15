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


func refine(type: RefinementType) -> void:
	is_refined = true
	refinement = type
	update_sprite()
	animate()


func animate() -> void:
	var tween = get_tree().create_tween()
	_sprite.scale = Vector3(0.4, 0.4, 0.4)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).tween_property(_sprite, "scale", Vector3(0.6, 0.6, 0.6), 0.2)
	tween.play()


func stringify() -> String:
	return data.name + " " + str(refinement)
