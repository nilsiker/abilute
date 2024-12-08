class_name AbiluteComponent extends Node

@export var attributes: Array[Attribute]

var effects: Array[Effect]:
	get:
		var array: Array[Effect]
		array.assign(find_children("*", "Effect", true, false))
		return array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Abilute.GROUP_NAME)
	_register_start_effects()

#region Attribute
func get_attribute_base(kind: Attribute.Kind):
	var candidates = attributes.filter(func(c): return c.kind == kind)
	if candidates.size() > 0:
		return candidates[0].base_value
	else:
		push_warning("no attribute of kind {0} found on {1}".format([Attribute.str(kind), get_parent().name]))
		return -1


# NOTE cache if too expensive
func get_attribute_value(kind: Attribute.Kind):
	var candidates = attributes.filter(func(c): return c.kind == kind)
	if candidates.size() > 0:
		var value = candidates[0].base_value
		for effect in find_children("*", "Effect", true, false):
			for modifier in effect.data.modifiers.filter(func(m): m.attribute == kind):
				match modifier.operation:
					Modifier.Operation.Add:
						value += modifier.magnitude
					Modifier.Operation.Multiply:
						value *= modifier.magnitude
					Modifier.Operation.Override:
						value = modifier.magnitude
		return value
	else:
		push_warning("no attribute of kind {0} found on {1}".format([Attribute.str(kind), get_parent().name]))
		return -1

func _pre_attribute_change(AttributeChange):
	pass
#endregion

#region Effects
# NOTE would it be sensible to have this as a static func in the Effect class?
func add_effect(effect: BaseEffect):
	var node = Effect.new(effect)
	node.application_requested.connect(_on_effect_application_requested)
	node.trigger_requested.connect(_on_effect_trigger_requested)
	node.removal_requested.connect(_on_effect_removal_requested)
	add_child(node)

func _register_start_effects():
	for effect in effects:
		effect.application_requested.connect(_on_effect_application_requested)
		effect.trigger_requested.connect(_on_effect_trigger_requested)
		effect.removal_requested.connect(_on_effect_removal_requested)


func _apply_effect(effect: BaseEffect):
	print("TODO handle on application logic for effects")

func _trigger_effect(effect: BaseEffect):
	if effect is InfiniteEffect:
		for modifier in effect.modifiers:
			var attribute = attributes.filter(func(a): return a.kind == modifier.attribute)
			if attribute.size() > 0:
				match modifier.operation:
					Modifier.Operation.Add:
						attribute[0].base_value += modifier.magnitude
					Modifier.Operation.Multiply:
						attribute[0].base_value *= modifier.magnitude
					Modifier.Operation.Override:
						attribute[0].base_value = modifier.magnitude
	elif effect is DurationEffect:
		for modifier in effect.modifiers:
			var attribute = attributes.filter(func(a): return a.kind == modifier.attribute)
			if attribute.size() > 0:
				match modifier.operation:
					Modifier.Operation.Add:
						attribute[0].base_value += modifier.magnitude
					Modifier.Operation.Multiply:
						attribute[0].base_value *= modifier.magnitude
					Modifier.Operation.Override:
						attribute[0].base_value = modifier.magnitude
	else: # BaseEffects are instant effects
		for modifier in effect.modifiers:
			var attribute = attributes.filter(func(a): return a.kind == modifier.attribute)
			if attribute.size() > 0:
				match modifier.operation:
					Modifier.Operation.Add:
						attribute[0].base_value += modifier.magnitude
					Modifier.Operation.Multiply:
						attribute[0].base_value *= modifier.magnitude
					Modifier.Operation.Override:
						attribute[0].base_value = modifier.magnitude
						
	for effect_to_remove in effect.removes:
		_remove_effect(effect_to_remove)
	for success_effect in effect.success_effects:
		add_effect(success_effect)

func _remove_effect(effect_to_remove: BaseEffect):
	for node in effects.filter(func(e): return e.data == effect_to_remove):
		node.queue_free()

func _on_effect_application_requested(effect: BaseEffect):
	for blocking_effect in effect.application_blocked_by:
		if effects.find(blocking_effect) > -1: return
	_apply_effect(effect)

func _on_effect_trigger_requested(effect: BaseEffect):
	for blocking_effect in effect.trigger_blocked_by:
		if effects.map(func(e): return e.data).find(blocking_effect) > -1: return
	_trigger_effect(effect)

func _on_effect_removal_requested(effect: BaseEffect):
	_remove_effect(effect)
#endregion
