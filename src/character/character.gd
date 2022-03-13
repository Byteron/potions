extends CharacterBody3D
class_name Character

var _item: Item = null

@onready var _item_container: Position3D = $ItemContainer
@onready var _anim: AnimationPlayer = $AnimationPlayer


func take_item(item: Item) -> void:
	_item = item
	_item_container.add_child(item)
	_anim.play("carry")


func drop_item() -> void:
	_item.queue_free()
	_item = null
	_anim.play("normal")


func has_item() -> bool:
	return _item != null
