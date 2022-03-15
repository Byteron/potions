extends Panel
class_name TitleScreen


@onready var score_label: Label = $CenterContainer/VBoxContainer/ScoreLabel


func _ready() -> void:
	score_label.text = "Score: " + str(int(Recipes.score))


func _on_play_button_pressed() -> void:
	get_tree().change_scene("res://src/game/shop.tscn")


func _on_recipe_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/recipe_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
