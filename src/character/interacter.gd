extends Node3D
class_name Interacter

@onready var _character: Character = get_parent()

@onready var interact_ray: RayCast3D = $InteractRayCast
@onready var refine_ray: RayCast3D = $RefineRayCast

var _interactable: Interactable = null


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()


func _process(_delta: float) -> void:
	update_interactable()

	if Input.is_action_pressed("refine"):
		refine()
	if Input.is_action_just_released("refine"):
		_character.anim.play("normal")
		finish_refine()


func update_interactable() -> void:
	if interact_ray.is_colliding():
		var area = interact_ray.get_collider()
		if area is Interactable:
			_change_interactable(area)
	elif _interactable != null:
		_change_interactable(null)

func interact() -> void:
	if _interactable != null:
		_interactable.interact(_character)


func refine() -> void:
	if not refine_ray.is_colliding() and _character.anim.current_animation == "refine":
		_character.anim.play("normal")
	
	if refine_ray.is_colliding():
		var area = refine_ray.get_collider()
		if area is Refiner:
			area.refine()
			if _character.anim.current_animation != "refine":
				_character.anim.play("refine")
			return


func finish_refine() -> void:
	_character.anim.play("normal")
	
	if refine_ray.is_colliding():
		var area = refine_ray.get_collider()
		if area is Refiner:
			area.finish()


func _change_interactable(interactable: Interactable) -> void:
	if _interactable != null:
		_interactable.dehighlight()
	
	_interactable = interactable
	
	if _interactable != null:
		_interactable.highlight()
