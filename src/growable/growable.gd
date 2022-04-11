extends Node3D
class_name Growable

var data: GrowableData = null

var _stage := -1

var is_grown := false

@onready var _sprite: Sprite3D = $Sprite3D
@onready var _timer: Timer = $Timer

var amount := 1

func _ready() -> void:
	_next_stage()
	amount = data.amount


func _next_stage() -> void:
	_stage += 1

	if data.stages.size() > _stage:
		_sprite.texture = data.stages[_stage]

	is_grown = data.stages.size() == _stage + 1
	
	if not is_grown:
		_timer.start(data.grow_time)
	
	animate()


func pick() -> void:
	amount -= 1
	_sprite.texture = data.images[amount - 1]


func animate(scale_factor := 0.7) -> void:
	var tween = get_tree().create_tween()
	_sprite.scale = Vector3(scale_factor, scale_factor, scale_factor)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).tween_property(_sprite, "scale", Vector3(1, 1, 1), 0.2)
	tween.play()


func _on_timer_timeout() -> void:
	_next_stage()

