class_name Ability extends Node

@export var data: AbilityData

var action: StringName:
	get: return data.action

var _owner: AbiluteComponent

func _init(data: AbilityData = null) -> void:
	self.data = data

func _ready() -> void:
	_owner = get_parent()
	name = data.resource_name


func can_activate() -> bool:
	if not data.cost_effect: return true
	return _owner.can_afford_cost(data.cost_effect)


func try_activate() -> bool:
	push_warning("override Ability try_activate method")
	return false


func apply_cost():
	_owner.add_effect(data.cost_effect)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(data.action):
		try_activate()
