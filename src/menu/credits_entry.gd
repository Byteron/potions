extends VBoxContainer
class_name CreditsEntry

var score := ""
var roles := ""

@onready var name_label: Label = $Name
@onready var score_label: Label = $Score
@onready var roles_label: Label = $Roles


func _ready() -> void:
	name_label.text = name
	score_label.text = score
	roles_label.text = roles

	if score.is_empty():
		score_label.hide()
