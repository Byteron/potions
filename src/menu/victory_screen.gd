extends Panel
class_name VictoryScreen

@export var CreditsEntry: PackedScene = null

@onready var score_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel
@onready var stats_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/StatsLabel
@onready var back_button: Button = $BackButton

@onready var credits_container: Control = $Credits

var credit_entries := [
	{
		name = "Aaron Winter",
		score = "18300",
		roles = "Game Design and Programming",
	},
	{
		name = "Zowie van Dillen",
		score = "15600",
		roles = "2D and 3D Art",
	},
	{
		name = "Ramita",
		score = "???",
		roles = "Sound Effects",
	},
	{
		name = "Vikfro",
		score = "???",
		roles = "3D Art and Music",
	},
]

var score := 0
var sold := 0
var failed := 0


func _ready() -> void:
	_init_credits()

	back_button.visible = false
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).tween_property(self, "score", Recipes.score, 3).set_delay(0.25)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).tween_property(self, "sold", Recipes.sold, 1).set_delay(0.25)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT).tween_property(self, "failed", Recipes.failed, 0.5).set_delay(0.25)
	
	for entry in credits_container.get_children():
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT).tween_property(entry, "modulate:a", 1.0, 0.5).set_delay(0.5)

	tween.tween_callback(back_button.show).set_delay(0.5)


func _process(delta: float) -> void:
	score_label.text = "Score: " + str(score)
	stats_label.text = "Sold: " + str(sold) + "\n" + "Failed: " + str(failed)


func _init_credits() -> void:
	for dict in credit_entries:
		var entry: CreditsEntry = CreditsEntry.instantiate()
		entry.modulate.a = 0
		entry.name = dict.name
		entry.score = dict.score
		entry.roles = dict.roles
		credits_container.add_child(entry)

func _on_back_button_pressed() -> void:
	get_tree().change_scene("res://src/menu/title_screen.tscn")
