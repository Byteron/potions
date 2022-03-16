extends Control
class_name OrderEntry

signal faded(order: OrderEntry)


@onready var potion_entry: PotionEntry = $VBoxContainer/PotionEntry
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar

var order: Order = null


func _ready() -> void:
	potion_entry.recipe = order.recipe
	potion_entry.update_info()


func _process(_delta: float) -> void:
	if order == null:
		return

	progress_bar.max_value = order.timer.wait_time
	progress_bar.value = order.timer.time_left


func remove() -> void:
	faded.emit(self)
	queue_free()
