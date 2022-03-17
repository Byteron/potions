extends Panel
class_name VictoryScreen

@onready var score_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel
@onready var stats_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/StatsLabel
@onready var back_button: Button = $BackButton

var score := 0
var sold := 0
var failed := 0


func _ready() -> void:
	back_button.visible = false
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).tween_property(self, "score", Recipes.score, 3).set_delay(0.25)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).tween_property(self, "sold", Recipes.sold, 1).set_delay(0.25)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT).tween_property(self, "failed", Recipes.failed, 0.5).set_delay(0.25)
	tween.tween_callback(back_button.show)


func _process(delta: float) -> void:
	score_label.text = "Score: " + str(score)
	stats_label.text = "Sold: " + str(sold) + "\n" + "Failed: " + str(failed)


func _on_back_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/title_screen.tscn")
