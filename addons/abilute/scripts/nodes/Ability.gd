class_name Ability extends Node

@export var _action: StringName
@export var cost_effect: BaseEffect

var action: StringName:
	get: return _action

var _owner: AbiluteComponent


func _ready() -> void:
	_owner = get_parent()


func can_activate() -> bool:
	return _owner.can_afford_cost(cost_effect)


func try_activate() -> bool:
	push_warning("override Ability try_activate method")
	return false


func apply_cost():
	_owner.add_effect(cost_effect)
