extends Node3D
class_name Space

var _item: Item = null

@onready var _container: Position3D = $Container


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item() and character.item is Item and not has_item():
		_item = character.drop_item()
		_container.add_child(_item)

	elif not character.has_item() and has_item():
		_container.remove_child(_item)
		character.take_item(_item)
		_item = null


func has_item() -> bool:
	return _item != null
