extends CanvasLayer
class_name HUD

@export var RecipeEntry: PackedScene = null

@onready var score_label: Label = $VBoxContainer2/ScoreLabel
@onready var time_label: Label = $VBoxContainer2/TimeLabel

@onready var container: Control = $VBoxContainer


func _ready() -> void:
	Recipes.orders_changed.connect(_on_orders_changed)
	_on_orders_changed()


func _process(_delta: float) -> void:
	score_label.text = "Score: " + str(Recipes.score)


func set_time_left(time_left: float) -> void:
	time_label.text = "Time: " + str(int(time_left))


func _on_orders_changed() -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	for order in Recipes.orders:
		var entry: PotionEntry = RecipeEntry.instantiate()
		entry.order = order
		container.add_child(entry)
