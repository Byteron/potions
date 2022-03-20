extends Control
class_name FloatingLabel

var position: Vector3
var text: String

@onready var label: Label = $Label


func _ready() -> void:
	label.text = text
	animate()


func initialize(position: Vector3, text: String) -> void:
	self.position = position
	self.text = text


func _process(_delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	
	if camera == null:
		queue_free()
	
	if camera.is_position_behind(position):
		hide()
	else:
		show()
	
	rect_global_position = camera.unproject_position(position)


func animate() -> void:
	var tween = get_tree().create_tween()
	rect_scale = Vector2()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).tween_property(self, "rect_scale", Vector2.ONE, 0.2).as_relative()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).tween_property(self, "position", Vector3.UP, 0.5).as_relative()
	tween.tween_callback(queue_free)
