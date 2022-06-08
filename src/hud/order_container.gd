extends Control
class_name OrderContainer

var orders := {}

@export var OrderEntry: PackedScene = null


func add_order(order: Order) -> void:
	var count = get_child_count()
	var entry: OrderEntry = OrderEntry.instantiate()
	entry.faded.connect(_on_entry_faded)
	entry.order = order
	add_child(entry)
	entry.position.y = entry.size.y * count + count * 5
	animate_in(entry)
	orders[order] = entry


func remove_order(order: Order, successful := false) -> void:
	var entry = orders[order]
	orders.erase(order)
	animate_out(entry, successful)


func animate_all_up() -> void:
	var index = 0
	for entry in orders.values():
		animate_up(entry, index)
		index += 1


func animate_in(entry: OrderEntry) -> void:
	var tween: Tween = get_tree().create_tween()
	entry.position.x -= entry.size.x
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).tween_property(entry, "position:x", entry.size.x, 0.5).as_relative()
	tween.play()


func animate_up(entry: OrderEntry, index: int) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).tween_property(entry, "position:y", entry.size.y * index, 0.5)
	tween.play()


func animate_out(entry: OrderEntry, successful: bool) -> void:
	entry.order = null
	var tween: Tween = get_tree().create_tween()
	
	if successful:
		tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).tween_property(entry, "modulate", Color("00FF00"), 0.25)
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).tween_property(entry, "modulate", Color("FFFFFF"), 0.25)
	else:
		tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).tween_property(entry, "modulate", Color("FF0000"), 0.25)
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).tween_property(entry, "modulate", Color("FFFFFF"), 0.25)
	
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).tween_property(entry, "position:x", -entry.size.x, 0.5).as_relative()
	tween.tween_callback(entry.remove)
	tween.play()


func _on_entry_faded(_entry: OrderEntry) -> void:
	animate_all_up()
