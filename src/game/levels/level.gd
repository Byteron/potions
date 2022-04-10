extends Node3D
class_name Level

enum {
	WON,
	LOST,
	
	# NO_OUTCOME is used if either the level doesn't have a goal or the goal is
	# already unlocked.
	NO_OUTCOME
}

@export var game_time := 240.0
@export var win_score := 10000
@export var win_unlocks_level := 0  # Zero signifies that a level has no goal.
@export var difficulty: Resource = null

func _ready() -> void:
	Recipes.difficulty = difficulty as Difficulty

func get_outcome(score, currently_unlocked_levels):
	if win_unlocks_level <= currently_unlocked_levels:
		return NO_OUTCOME
	return WON if score >= win_score else LOST
