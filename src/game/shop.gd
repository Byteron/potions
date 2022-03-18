extends Node3D
class_name Shop

@export var game_time := 300.0

@onready var hud: HUD = $HUD
@onready var timer: Timer = $GameTimer
@onready var sound_timer: Timer = $GameOverTimer

@onready var game_over_player: AudioStreamPlayer = $GameOverPlayer
@onready var character: Character = $Character


func _ready() -> void:
	Recipes.reset()
	Recipes.start()
	timer.start(game_time)
	sound_timer.start(game_time - 10)


func _process(_delta: float) -> void:
	hud.set_time_left(timer.time_left)


func _on_game_timer_timeout() -> void:
	var timer := get_tree().create_timer(2.5)
	Recipes.stop()
	Recipes.clear()
	character.disable()
	await timer.timeout
	get_tree().change_scene("res://src/menu/victory_screen.tscn")


func _on_game_over_timer_timeout() -> void:
	game_over_player.play()
