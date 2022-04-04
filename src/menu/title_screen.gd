extends Control
class_name TitleScreen

signal play_pressed()
signal recipe_pressed()

var levels: Array = [
	load("res://src/game/level1.tscn"),
	load("res://src/game/level2.tscn"),
	load("res://src/game/level3.tscn"),
]

@export var LevelButton: PackedScene = null

@onready var play_button: Button = $CenterContainer/VBoxContainer/PlayButton


func _ready() -> void:
	enable()


func enable() -> void:
	show()
	play_button.grab_focus()


func disable() -> void:
	play_button.release_focus()
	hide()


func _on_play_button_pressed() -> void:
	play_pressed.emit()


func _on_recipe_button_pressed() -> void:
	recipe_pressed.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


