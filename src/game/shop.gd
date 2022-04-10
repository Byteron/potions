extends Node3D
class_name Shop

@export var skip_intro = false

@export var levels: Array[PackedScene]

@onready var hud: HUD = $HUD
@onready var timer: Timer = $GameTimer
@onready var sound_timer: Timer = $GameOverTimer

@onready var game_over_player: AudioStreamPlayer = $GameOverPlayer

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: AudioStreamPlayer = $AudioStreamPlayer
@onready var rect: ColorRect = $Intro/ColorRect

var level: Level = null


func _ready() -> void:
	if Recipes.play_intro and not skip_intro:
		anim.play("intro")
		await anim.animation_finished
		Recipes.play_intro = false
	else:
		rect.visible = false
	
	hud.show_menu()


func start() -> void:
	hud.show_labels()
	Recipes.reset()
	Recipes.start()
	timer.start(level.game_time)
	sound_timer.start(level.game_time - 10)
	player.play()


func _process(_delta: float) -> void:
	hud.set_time_left(timer.time_left)


func _change_level(index: int) -> void:
	if level != null:
		level.queue_free()
		level = null
	
	level = levels[index].instantiate()
	add_child(level)


func _on_game_timer_timeout() -> void:
	var timer := get_tree().create_timer(2.5)
	Recipes.stop()
	Recipes.clear()
	player.stop()
	await timer.timeout
	hud.show_score()


func _on_game_over_timer_timeout() -> void:
	game_over_player.play()


func _on_hud_level_selected(level: int) -> void:
	_change_level(level)
	anim.play("camera_out")
	await anim.animation_finished
	start()

func _on_hud_back_pressed() -> void:
	anim.play("camera_in")
	await anim.animation_finished
	get_tree().reload_current_scene()
