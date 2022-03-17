extends CanvasLayer

const MAX_LINES = 10

var _lines: Array[String] = []

@onready var label: Label = $Label


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible


func _ready() -> void:
	write("logging enabled")


func write(string: String) -> void:
	_lines.append(string)
	
	if _lines.size() > MAX_LINES:
		var __ = _lines.pop_front()

	_update_label()


func _update_label() -> void:
	var s = ""
	
	for line in _lines:
		s += line + "\n"
	
	label.text = s
