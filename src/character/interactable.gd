extends Area3D
class_name Interactable

signal interacted(character: Character)

@onready var cursor: Node3D = $Cursor 

func _ready() -> void:
	cursor.visible = false


func highlight() -> void:
	cursor.visible = true


func dehighlight() -> void:
	cursor.visible = false


func interact(character: Character) -> void:
	interacted.emit(character)
