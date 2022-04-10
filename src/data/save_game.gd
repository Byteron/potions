extends Resource
class_name SaveGame

@export var unlocked_levels = 0


static func load() -> SaveGame:
	var save_game = load("user://save.tres")
	if save_game == null:
		return SaveGame.new()
	return save_game


func save() -> void:
	ResourceSaver.save("user://save.tres", self)
