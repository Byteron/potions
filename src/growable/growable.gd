extends Node3D
class_name Growable

enum TYPE { HERB, ROOT, FLOWER, MUSHROOM }

var data: GrowableData = null
var _type: TYPE = TYPE.HERB
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
		_timer.start()


func _on_timer_timeout() -> void:
	_next_stage()
