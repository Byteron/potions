extends Node3D
class_name Dirt

var _growable: Growable = null

@export var Growable: PackedScene = null
@export var Item: PackedScene = null

@onready var _container: Position3D = $Container


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and not has_growable():
		character.drop_item()
		_growable = Growable.instantiate()
		_container.add_child(_growable)

	elif not character.has_item() and has_growable():
		var item = Item.instantiate()
		character.take_item(item)
		_growable.queue_free()
		_growable = null


func has_growable() -> bool:
	return _growable != null
