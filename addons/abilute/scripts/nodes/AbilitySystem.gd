class_name AbilitySystem extends Node


var attributes: Array[Attribute]:
	get:
		# NOTE maybe cache this
		var array: Array[Attribute]
		array.assign(find_children("*", "Attribute", true, false))
		return array

@export var effects: Array[Effect]:
	get: 
		var array: Array[Effect] 
		array.assign(find_children("*", "Effect", true, false))
		return array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("AbilitySystems")


# NOTE would it be sensible to have this as a static func in the Effect class?
func add_effect(effect: EffectResource):
	var node = Effect.new(effect)
	node.application_requested.connect(_on_effect_application_requested)
	node.trigger_requested.connect(_on_effect_trigger_requested)
	node.removal_requested.connect(_on_effect_removal_requested)
	add_child(node)

func get_attribute_base(kind: AttributeResource.Kind):
	var candidates = get_children().filter(func(c): return c is Attribute and c.data.kind == kind)
	if candidates.size() > 0:
		return candidates[0].data.base_value
	else:
		push_warning("no attribute of kind {} found".format([Attribute.str(kind)]))
		return -1

# NOTE cache if too expensive
func get_attribute_value(kind: AttributeResource.Kind):
	var candidates = get_children().filter(func(c): return c is Attribute and c.data.kind == kind)
	if candidates.size() > 0:
		var value = candidates[0].data.base_value
		for effect in find_children("*", "Effect", true, false):
			for modifier in effect.modifiers.filter(func(m): m.attribute == kind):
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

func _apply_effect(effect: EffectResource):
	print("TODO handle on application logic for effects")

func _trigger_effect(effect: EffectResource):
	for modifier in effect.modifiers:
		var attribute_name = Attribute.str(modifier.attribute)
		var attribute: Attribute = get_node(attribute_name) as Attribute
		if attribute:
			attribute.add(modifier.magnitude)
	for success_effect in effect.success_effects:
		add_effect(success_effect)

func _remove_effect(effect: EffectResource):
	print("TODO implement effect removal (", effect.resource_name, ")")


#region Signal handlers
func _on_effect_application_requested(effect: EffectResource):
	for blocking_effect in effect.application_blocked_by:
		if effects.find(blocking_effect) > -1: return
	_apply_effect(effect)

func _on_effect_trigger_requested(effect: EffectResource):
	for blocking_effect in effect.trigger_blocked_by:
		print(effects)
		if effects.map(func(e): return e.data).find(blocking_effect) > -1: return
	_trigger_effect(effect)

func _on_effect_removal_requested(effect: EffectResource):
	_remove_effect(effect)
#endregion
