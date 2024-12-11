extends Ability

@export var action: StringName

func try_activate() -> bool:
	if not can_activate(): return false
	apply_cost()
	
	print("jump!")

	return false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(action):
		try_activate()