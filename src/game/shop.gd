extends Node3D
class_name Shop

@onready var hud: HUD = $HUD
@onready var timer: Timer = $GameTimer

@export var game_time := 300.0


func _ready() -> void:
	Recipes.reset()
	Recipes.start()
	timer.start(game_time)


func _process(_delta: float) -> void:
	hud.set_time_left(timer.time_left)


func _on_game_timer_timeout() -> void:
	Recipes.stop()
	Recipes.clear()
	get_tree().change_scene("res://src/menu/title_screen.tscn")
