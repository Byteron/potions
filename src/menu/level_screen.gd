extends Control
class_name LevelScreen

signal level_selected(level: int)
signal back_pressed()

@export var LevelButton: PackedScene = null

@onready var container: Control = $CenterContainer/VBoxContainer


func _ready() -> void:
	for level in 3:
		var button: Button = LevelButton.instantiate()
		button.text = ["Easy", "Medium", "Hard"][level]
		button.pressed.connect(_on_level_selected.bind(level))
		container.add_child(button)


func enable() -> void:
	show()


func disable() -> void:
	hide()


func _on_level_selected(level: int) -> void:
	level_selected.emit(level)


func _on_back_button_pressed() -> void:
	back_pressed.emit()
