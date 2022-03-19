extends Node3D
class_name Customers

@onready var customers : Array = get_children()


func _ready() -> void:

	for customer in customers:
		customer.rotation.y = deg2rad(randf_range(0, 360))
		var mesh_instance: MeshInstance3D = customer.get_node("Sphere001")
		mesh_instance.transparency = 1.0

	Recipes.orders_changed.connect(_update_customers)
	_update_customers()


func _update_customers() -> void:
	var tween := get_tree().create_tween()
	
	customers.shuffle()

	for i in range(Recipes.orders.size(), 5):
		var mesh_instance: MeshInstance3D = customers[i].get_node("Sphere001")
		tween.parallel().tween_property(mesh_instance, "transparency", 1.0, 0.1)

	for i in Recipes.orders.size():
		var mesh_instance: MeshInstance3D = customers[i].get_node("Sphere001")
		tween.parallel().tween_property(mesh_instance, "transparency", 0.0, 0.1)

	tween.play()
