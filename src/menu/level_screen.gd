extends Control
class_name LevelScreen

signal level_selected(level: int)
signal back_pressed()

@export var LevelButton: PackedScene = null

@onready var back_button: Button = $BackButton
@onready var container: Control = $CenterContainer/VBoxContainer
var buttons: Array[Button] = []


func _ready() -> void:
	for level in 3:
		var button: Button = LevelButton.instantiate()
		button.text = [
				"Level 1: Raw crops",
				"Level 2: Chopped",
				"Level 3: Drying & Grinding"
			][level]
		button.pressed.connect(_on_level_selected.bind(level))
		buttons.append(button)
		container.add_child(button)
	
	buttons.append(back_button)
	
	for i in buttons.size():
		buttons[i].focus_neighbor_top = buttons[i - 1].get_path()
		buttons[i].focus_neighbor_bottom = buttons[(i + 1) % buttons.size()].get_path()


func enable(highest_unlocked_level: int) -> void:
	show()
	_update_unlocked_levels(highest_unlocked_level)
	buttons[0].grab_focus()

func disable() -> void:
	buttons[0].release_focus()
	hide()


func _on_level_selected(level: int) -> void:
	level_selected.emit(level)


func _on_back_button_pressed() -> void:
	back_pressed.emit()


func _update_unlocked_levels(highest_unlocked_level: int) -> void:
	for i in buttons.size():
		if buttons[i] != back_button:
			buttons[i].disabled = (i > highest_unlocked_level)
