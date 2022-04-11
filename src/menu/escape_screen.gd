extends Control
class_name EscapeScreen

const ESCAPE_TIME := 3.0

signal escape_pressed()

@onready var progress_bar: ProgressBar = $CenterContainer/Label/ProgressBar
@onready var label: Label = $CenterContainer/Label


var press_time := 0.0
var enabled := false


func _ready() -> void:
	progress_bar.max_value = ESCAPE_TIME
	hide()


func enable() -> void:
	enabled = true


func disable() -> void:
	enabled = false


func _process(delta: float) -> void:
	if not enabled:
		return
	
	if Input.is_action_pressed("escape"):
		press_time += delta
		show()
	elif Input.is_action_just_released("escape"):
		press_time = 0
		hide()

	progress_bar.value = press_time
	
	if press_time > ESCAPE_TIME:
		escape_pressed.emit()
		press_time = 0
		hide()
		disable()
