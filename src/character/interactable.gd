extends Area3D
class_name Interactable

signal interacted(character: Character)

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D 

func _ready() -> void:
	mesh_instance.visible = false


func highlight() -> void:
	mesh_instance.visible = true


func dehighlight() -> void:
	mesh_instance.visible = false


func interact(character: Character) -> void:
	interacted.emit(character)
