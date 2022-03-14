extends CanvasLayer
class_name HUD

@export var RecipeEntry: PackedScene = null

@onready var score_label: Label = $ScoreLabel
@onready var container: Control = $VBoxContainer


func _ready() -> void:
	Recipes.orders_changed.connect(_on_orders_changed)
	_on_orders_changed()

func _process(delta: float) -> void:
	score_label.text = "Score: " + str(Recipes.score)


func _on_orders_changed() -> void:
	print("_on_orders_changed")
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	for order in Recipes.orders:
		var entry: PotionEntry = RecipeEntry.instantiate()
		entry.order = order
		container.add_child(entry)
