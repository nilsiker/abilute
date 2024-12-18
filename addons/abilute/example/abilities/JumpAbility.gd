extends Ability

@export var _action: StringName
@export var _jump_strength: float = 400

var _body: CharacterBody2D

func _ready() -> void:
	super._ready()
	_body = _owner.get_parent() as CharacterBody2D


func try_activate() -> bool:
	if not can_activate(): return false
	apply_cost()
	
	_body.velocity.y = -_jump_strength

	return false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(_action):
		try_activate()


func can_activate() -> bool:
	if not super.can_activate(): return false

	return _body.is_on_floor()