extends Control
class_name VictoryScreen

signal back_pressed()

@export var CreditsEntry: PackedScene = null

@onready var score_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel
@onready var stats_label: Label = $VBoxContainer/CenterContainer/VBoxContainer/StatsLabel
@onready var back_button: Button = $BackButton

@onready var credits_container: Control = $Credits

var credit_entries : Array[Dictionary] = [
	{
		name = "Aaron Winter",
		roles = "Game Design and Programming",
	},
	{
		name = "Zowie van Dillen",
		roles = "2D and 3D Art",
	},
	{
		name = "Vikfro",
		roles = "3D Art and Music",
	},
	{
		name = "Geoffrey Muller",
		roles = "Key Art and Logo Design",
	},
	{
		name = "Ramita",
		roles = "Sound Effects",
	},
]

var scores : Dictionary = {
	"Aaron Winter" = [
		16800,
		19600,
		19900,
	],
	"Zowie van Dillen" = [
		15200,
		23600,
		15600,
	],
	"Vikfro" = [0, 0, 0],
	"Geoffrey Muller" = [0, 0, 0],
	"Ramita" = [0, 0, 0],
}

var score := 0
var sold := 0
var failed := 0

var level := 0


func _process(_delta: float) -> void:
	score_label.text = "Score: " + str(score)
	stats_label.text = "Sold: " + str(sold) + "\n" + "Failed: " + str(failed)


func enable(level: int) -> void:
	self.level = level

	show()
	start()


func disable() -> void:
	hide()


func start() -> void:
	_update_credits()

	back_button.visible = false

	for entry in credits_container.get_children():
		entry.modulate.a = 0
	
	score = 0
	sold = 0
	failed = 0
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).tween_property(self, "score", Recipes.score, 3).set_delay(0.25)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).tween_property(self, "sold", Recipes.sold, 1).set_delay(0.25)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT).tween_property(self, "failed", Recipes.failed, 0.5).set_delay(0.25)
	
	for entry in credits_container.get_children():
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT).tween_property(entry, "modulate:a", 1.0, 0.5).set_delay(0.5)

	tween.tween_callback(back_button.show).set_delay(0.5)
	tween.tween_callback(back_button.grab_focus)


func _update_credits() -> void:
	for child in credits_container.get_children():
		credits_container.remove_child(child)
		child.queue_free()

	for dict in credit_entries:
		var entry: CreditsEntry = CreditsEntry.instantiate()
		entry.modulate.a = 0
		entry.name = dict.name
		if scores[entry.name][level] != 0:
			entry.score = "High Score: %d" % scores[entry.name][level]
		else:
			entry.score = ""

		entry.roles = dict.roles
		credits_container.add_child(entry)


func _on_back_button_pressed() -> void:
	back_pressed.emit()
