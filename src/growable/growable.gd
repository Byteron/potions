extends Node3D
class_name Growable

enum TYPE { HERB, ROOT, FLOWER, MUSHROOM }

var _type: TYPE = TYPE.HERB

@onready var _sprite: Sprite3D = $Sprite3D


func is_grown() -> bool:
	return true
