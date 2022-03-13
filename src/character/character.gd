extends CharacterBody3D
class_name Character

var item: Item = null

@onready var _item_container: Position3D = $ItemContainer
@onready var _anim: AnimationPlayer = $AnimationPlayer


func take_item(item: Item) -> void:
	self.item = item
	_item_container.add_child(item)
	_anim.play("carry")


func drop_item() -> Item:
	_item_container.remove_child(self.item)
	var item = self.item
	self.item = null
	_anim.play("normal")
	return item


func has_item() -> bool:
	return item != null
