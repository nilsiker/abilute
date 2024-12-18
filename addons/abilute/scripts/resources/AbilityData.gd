class_name AbilityData extends Resource

@export var _class: Script
@export var action: StringName
@export var cost_effect: BaseEffect

func create() -> Ability:
	return _class.new(self)
