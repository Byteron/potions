extends Panel
class_name TitleScreen

@onready var play_button: Button = $CenterContainer/VBoxContainer/PlayButton

func _ready() -> void:
	play_button.grab_focus()


func _on_play_button_pressed() -> void:
	get_tree().change_scene("res://src/game/shop.tscn")


func _on_recipe_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/recipe_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
