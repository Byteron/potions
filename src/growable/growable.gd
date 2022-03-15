extends Node3D
class_name Growable

enum Type { HERB, ROOT, FLOWER, MUSHROOM }

var data: GrowableData = null
var type: Type = Type.HERB

var _stage := -1

var is_grown := false

@onready var _sprite: Sprite3D = $Sprite3D
@onready var _timer: Timer = $Timer


func _ready() -> void:
	_next_stage()
	

func _next_stage() -> void:
	_stage += 1

	if data.stages.size() > _stage:
		_sprite.texture = data.stages[_stage]

	is_grown = data.stages.size() == _stage + 1
	
	if not is_grown:
		_timer.start(data.grow_time)
	
	animate()


func animate() -> void:
	var tween = get_tree().create_tween()
	_sprite.scale = Vector3(0.7, 0.7, 0.7)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).tween_property(_sprite, "scale", Vector3(1, 1, 1), 0.2)
	tween.play()


func _on_timer_timeout() -> void:
	_next_stage()

