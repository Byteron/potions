extends Control
class_name RecipeMenu

@export var PotionEntry: PackedScene = null

@onready var container: Control = $VBoxContainer/CenterContainer/GridContainer
@onready var back_button: Button = $VBoxContainer/BackButton


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_back_button_pressed()


func _ready() -> void:
	for recipe in Recipes.recipes:
		var entry: PotionEntry = PotionEntry.instantiate()
		entry.recipe = recipe
		container.add_child(entry)
		entry.update_info()

	back_button.grab_focus()


func _on_back_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/title_screen.tscn")
