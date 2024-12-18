class_name AbiluteComponent extends Node

signal attribute_base_value_changed(data: Attribute.ChangeData)
signal attribute_value_changed(data: Attribute.ChangeData)
signal effect_added(data: BaseEffect)
signal effect_removed(data: BaseEffect)
signal ability_granted(ability: Ability)
signal ability_revoked(ability: Ability)

@export var attributes: Array[AttributeData]

var effects: Array[Effect]:
	get:
		var array: Array[Effect]
		var found = find_children("*", "Effect", true, false)
		array.assign(found)
		return array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Abilute.GROUP_NAME)
	_init_attributes()
	_register_start_effects()

#region Attributes
func get_attribute_base(attribute: StringName):
	var node: Attribute = find_children(attribute, "Attribute", true, false).front()
	return node.base_value

func get_attribute_value(attribute: StringName):
	var node: Attribute = find_children(attribute, "Attribute", true, false).front()
	return node.value

func _init_attributes():
	var created = []
	for attribute in attributes:
		var node: Attribute = Attribute.new(attribute)
		node.value_changed.connect(_on_attribute_value_changed)
		node.base_value_changed.connect(_on_attribute_base_value_changed)
		add_child(node)
		created.push_back(node)
	for node in created: node.init()
	
	
func _on_attribute_base_value_changed(data: Attribute.ChangeData):
	attribute_base_value_changed.emit(data)

func _on_attribute_value_changed(data: Attribute.ChangeData):
	attribute_value_changed.emit(data)
#endregion

#region Effects
func add_effect(effect: BaseEffect):
	var existing_effect = effects.filter(func(e): return e.data == effect).pop_back()
	if existing_effect: # FIXME this is quick and dirty
		if existing_effect.data is DurationEffect and existing_effect.data.allow_reapply: # FIXME this quick and dirty
			existing_effect.queue_free()
		else:
			return
	var node = Effect.new(effect)
	node.application_requested.connect(_on_effect_application_requested)
	node.trigger_requested.connect(_on_effect_trigger_requested)
	node.removal_requested.connect(_on_effect_removal_requested)
	add_child(node)

func remove_effect(effect: BaseEffect):
	var existing_effect = effects.filter(func(e): return e.data == effect).pop_back()
	if existing_effect:
		_remove_effect(existing_effect)


func can_afford_cost(effect: BaseEffect) -> bool:
	return effect.modifiers.all(func(m: ModifierData):
		return -m.magnitude <= get_attribute_value(m.attribute)
	)

func _register_start_effects():
	for effect in effects:
		effect.application_requested.connect(_on_effect_application_requested)
		effect.trigger_requested.connect(_on_effect_trigger_requested)
		effect.removal_requested.connect(_on_effect_removal_requested)
		_apply_effect(effect)


func _apply_effect(effect: Effect):
	print("todo apply effect logic")
	if effect.data is BaseEffect:
		_trigger_effect(effect)

## Effect trigger effects always modify base value
func _trigger_effect(effect: Effect):
	for modifier in effect.data.modifiers:
		var attribute: Attribute = get_node(str(modifier.attribute))
		if attribute:
			if effect.data.modifies_base:
				attribute.add_base_modifier(Modifier.new(modifier))
			else:
				attribute.add_modifier(Modifier.new(modifier, effect.tree_exited))

	for effect_data in effect.data.removes:
		var node = find_children("*", "Effect", true, false).filter(func(e): return e.data == effect_data).front()
		if node: _remove_effect(node)
	for success_effect in effect.data.success_effects:
		add_effect(success_effect)

func _remove_effect(effect: Effect):
	effect.queue_free()

func _on_effect_application_requested(effect: Effect):
	var data = effect.data
	for blocking_effect in data.application_blocked_by:
		if effects.find(blocking_effect) > -1: return
	_apply_effect(effect)

func _on_effect_trigger_requested(effect: Effect):
	for blocking_effect in effect.data.trigger_blocked_by:
		if effects.map(func(e): return e.data).find(blocking_effect) > -1: return
	_trigger_effect(effect)

func _on_effect_removal_requested(effect: Effect):
	_remove_effect(effect)
#endregion
