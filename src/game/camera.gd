extends Node3D

@export var target_node: NodePath
@onready var target: Node3D = get_node(target_node)


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not target:
		return
	
	position = target.position
