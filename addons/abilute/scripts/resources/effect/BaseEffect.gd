class_name BaseEffect extends Resource

@export var modifiers: Array[ModifierData]
@export var trigger_blocked_by: Array[BaseEffect]
@export var application_blocked_by: Array[BaseEffect]
@export var removes: Array[BaseEffect]
@export var success_effects: Array[BaseEffect]
@export var failure_effects: Array[BaseEffect]

var modifies_base: bool:
	get: return _modifies_base()

func _modifies_base() -> bool:
	return true