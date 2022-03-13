extends Node3D

@export var _target_node: NodePath
@onready var _target: Node3D = get_node(_target_node)


func _process(_delta: float) -> void:
	if not _target:
		return
	
	position = _target.position
