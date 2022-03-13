extends CharacterBody3D
class_name Character

var _item: Item = null

@onready var _item_container: Position3D = $ItemContainer


func take_item(item: Item) -> void:
	_item = item
	_item_container.add_child(item)


func drop_item() -> void:
	_item.queue_free()
	_item = null


func has_item() -> bool:
	return _item != null
