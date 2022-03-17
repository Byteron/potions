extends CharacterBody3D
class_name Character

var item: Item = null

@onready var _item_container: Position3D = $ItemContainer
@onready var anim: AnimationPlayer = $AnimationPlayer


@onready var take_player: AudioStreamPlayer3D = $TakePlayer
@onready var drop_player: AudioStreamPlayer3D = $DropPlayer

@onready var controller = $Controller
@onready var interacter = $Interacter


func disable() -> void:
	controller.queue_free()
	interacter.queue_free()


func take_item(new_item: Item) -> void:
	self.item = new_item
	_item_container.add_child(new_item)
	anim.play("carry")
#	take_player.play()


func drop_item() -> Item:
	_item_container.remove_child(self.item)
	var dropping_item = self.item
	self.item = null
	anim.play("normal")
#	drop_player.play()
	return dropping_item


func has_item() -> bool:
	Debug.write("has item" + str(item != null))
	return item != null
