extends Control
class_name FloatingLabel

var world_position: Vector3
var text: String

@onready var label: Label = $Label


func _ready() -> void:
	label.text = text
	animate()


func initialize(world_position: Vector3, text: String) -> void:
	self.world_position = world_position
	self.text = text


func _process(_delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	
	if camera == null:
		queue_free()
	
	if camera.is_position_behind(world_position):
		hide()
	else:
		show()
	
	global_position = camera.unproject_position(world_position)


func animate() -> void:
	scale = Vector2()
	get_tree().create_tween() \
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).tween_property(self, "scale", Vector2.ONE, 0.2).as_relative() \
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).tween_property(self, "position", Vector3.UP, 0.5).as_relative() \
		.tween_callback(queue_free) \
		.play()
