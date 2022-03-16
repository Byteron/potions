extends CanvasLayer
class_name HUD

@onready var score_label: Label = $VBoxContainer2/ScoreLabel
@onready var time_label: Label = $VBoxContainer2/TimeLabel

@onready var container: OrderContainer = $OrderContainer


func _process(_delta: float) -> void:
	score_label.text = "Score: " + str(Recipes.score)


func add_order(order: Order) -> void:
	container.add_order(order)


func remove_order(order: Order, successful := false) -> void:
	container.remove_order(order, successful)


func set_time_left(time_left: float) -> void:
	time_label.text = "Time: " + str(int(time_left))
