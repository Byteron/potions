extends Node3D
class_name SeedBag

@export var Seed: PackedScene = null
@export var growable: Resource = null

@onready var sprite: Sprite3D = $Sprite3D


func _ready() -> void:
	sprite.texture = growable.ingredient_data.default_texture


func _on_interactable_interacted(character: Character) -> void:
	if not character.has_item():
		var seed: Seed = Seed.instantiate()
		seed.data = growable
		character.take_item(seed)
