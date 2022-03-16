extends Panel
class_name VictoryScreen

@onready var score_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel
@onready var stats_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/StatsLabel

func _ready() -> void:
	score_label.text = "Score: " + str(Recipes.score)
	stats_label.text = "Sold: " + str(Recipes.sold) + "\n" + "Failed: " + str(Recipes.failed)


func _on_back_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/title_screen.tscn")
