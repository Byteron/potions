extends Control
class_name HelpMenu

signal back_pressed()

@onready var back_button: Button = $BackButton


func enable() -> void:
	show()
	back_button.grab_focus()


func disable() -> void:
	back_button.release_focus()
	hide()


func _on_back_button_pressed() -> void:
	back_pressed.emit()
