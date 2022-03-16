extends Panel
class_name TitleScreen


func _on_play_button_pressed() -> void:
	get_tree().change_scene("res://src/game/shop.tscn")


func _on_recipe_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/recipe_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
