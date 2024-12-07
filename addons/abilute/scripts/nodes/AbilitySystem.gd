class_name AbilitySystem extends Node


var attributes: Array[Attribute]:
	get:
		# NOTE maybe cache this
		var array: Array[Attribute]
		array.assign(find_children("*", "Attribute", true, false))
		return array

@export var tags: Dictionary:
	get:
		var tags = {}
		for child in find_children("*", "Effect", true, false):
			if child.effect.tags:
				for tag in child.effect.tags.applies:
					tags[tag] = true
		return tags

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("AbilitySystems")

func add_effect(effect: EffectResource):
	var node = Effect.new(effect)
	node.application_requested.connect(_on_effect_application_requested)
	node.trigger_requested.connect(_on_effect_trigger_requested)
	node.removal_requested.connect(_on_effect_removal_requested)
	add_child(node)


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
	if effect.tags:
		for tag in effect.tags.blocked_on_application:
			if tags.get(tag): return
	_apply_effect(effect)

func _on_effect_trigger_requested(effect: EffectResource):
	if effect.tags:
		for tag in effect.tags.blocked_on_trigger:
			if tags.get(tag): return
	_trigger_effect(effect)

func _on_effect_removal_requested(effect: EffectResource):
	_remove_effect(effect)
#endregion
