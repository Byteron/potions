extends Node3D
class_name Bin


@onready var trash_player: AudioStreamPlayer3D = $TrashPlayer


func _on_interactable_interacted(character: Character) -> void:
	if character.has_item():
		trash_player.play()
		character.drop_item()
