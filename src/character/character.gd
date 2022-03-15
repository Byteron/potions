extends CharacterBody3D
class_name Character

var item: Item = null

@onready var _item_container: Position3D = $ItemContainer
@onready var anim: AnimationPlayer = $AnimationPlayer


func take_item(new_item: Item) -> void:
	self.item = new_item
	_item_container.add_child(new_item)
	anim.play("carry")


func drop_item() -> Item:
	_item_container.remove_child(self.item)
	var dropping_item = self.item
	self.item = null
	anim.play("normal")
	return dropping_item


func has_item() -> bool:
	return item != null
