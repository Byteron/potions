extends Node

const MAX_ORDERS = 5

signal orders_changed()

var recipes: Array[Recipe] = [
	load("data/recipes/love_potion.tres") as Recipe,
	load("data/recipes/health_potion.tres") as Recipe,
	load("data/recipes/youth_potion.tres") as Recipe,
]

var orders: Array[Order]

var score := 0

@export var Order: PackedScene = null

@onready var order_container: Node = $Orders


func _ready() -> void:
	randomize()

	for recipe in recipes:
		print(recipe.name)
	
	_on_new_recipe_timer_timeout()
	_on_new_recipe_timer_timeout()


func _on_new_recipe_timer_timeout() -> void:
	if order_container.get_child_count() == MAX_ORDERS:
		return
	
	var index = randi() % recipes.size()
	print("new order: ", index)
	var recipe = recipes[index]
	
	var order: Order = Order.instantiate()
	order.expired.connect(_on_order_expired)
	order.finished.connect(_on_order_finished)
	order.recipe = recipe
	orders.append(order)
	order_container.add_child(order)

	orders_changed.emit()


func _on_order_expired(order: Order) -> void:
	orders.erase(order)
	orders_changed.emit()


func _on_order_finished(order: Order) -> void:
	var modifier: int = order.get_time_left_modifier()
	print(order.recipe.score, " * ", modifier)
	score += order.recipe.score * modifier
	orders.erase(order)
	orders_changed.emit()
