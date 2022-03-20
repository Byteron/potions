extends Node

const MAX_ORDERS = 5

signal orders_changed()


var recipes: Array[Recipe] = [
	load("data/recipes/health_potion.tres") as Recipe,
	load("data/recipes/mana_potion.tres") as Recipe,
	load("data/recipes/love_potion.tres") as Recipe,
	load("data/recipes/youth_potion.tres") as Recipe,
	load("data/recipes/insight_potion.tres") as Recipe,
	load("data/recipes/shrink_potion.tres") as Recipe,
	load("data/recipes/luck_potion.tres") as Recipe,
	load("data/recipes/happiness_potion.tres") as Recipe,
	load("data/recipes/fertility_potion.tres") as Recipe,
	load("data/recipes/courage_potion.tres") as Recipe,
	load("data/recipes/sleep_potion.tres") as Recipe,
	load("data/recipes/grow_potion.tres") as Recipe,
	load("data/recipes/cleansing_potion.tres") as Recipe,
	load("data/recipes/poison_potion.tres") as Recipe,
	load("data/recipes/beauty_potion.tres") as Recipe,
	load("data/recipes/ancient_potion.tres") as Recipe,
]

var orders: Array[Order]

var score := 0
var sold := 0
var failed := 0

var play_intro := true

@export var Order: PackedScene = null
@export var FloatingLabel: PackedScene = null

@onready var order_container: Node = $Orders
@onready var timer: Timer = $NewRecipeTimer

@onready var ring_player: AudioStreamPlayer = $RingPlayer
@onready var fulfilled_player: AudioStreamPlayer = $FulfilledPlayer
@onready var failed_player: AudioStreamPlayer = $FailedPlayer


func _ready() -> void:
	randomize()


func stop() -> void:
	timer.stop()


func start() -> void:
	timer.start()


func reset() -> void:
	score = 0
	sold = 0
	failed = 0


func clear() -> void:
	for child in order_container.get_children():
		order_container.remove_child(child)
		child.queue_free()

	orders.clear()


func _on_new_recipe_timer_timeout() -> void:
	if order_container.get_child_count() == MAX_ORDERS:
		return
	
	var index = randi() % recipes.size()
	var recipe = recipes[index]
	
	var order: Order = Order.instantiate()
	order.expired.connect(_on_order_expired)
	order.finished.connect(_on_order_finished)
	order.recipe = recipe
	orders.append(order)
	order_container.add_child(order)
	
	get_tree().call_group("HUD", "add_order", order)
	ring_player.play()
	orders_changed.emit()


func _on_order_finished(order: Order, position: Vector3) -> void:
	var modifier := int(order.get_time_left_modifier())
	var potion_score = order.recipe.score * modifier
	score += potion_score
	var label: FloatingLabel = FloatingLabel.instantiate()
	label.initialize(position, str(potion_score))
	get_tree().current_scene.add_child(label)
	
	get_tree().call_group("HUD", "remove_order", order, true)
	orders.erase(order)
	order.queue_free()
	fulfilled_player.play()
	sold += 1
	orders_changed.emit()

func _on_order_expired(order: Order) -> void:
	score -= 500
	orders.erase(order)
	get_tree().call_group("HUD", "remove_order", order, false)
	order.queue_free()
	failed_player.play()
	failed += 1
	orders_changed.emit()
