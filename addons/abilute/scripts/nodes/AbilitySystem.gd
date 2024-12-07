class_name AbilitySystem extends Node


var attributes: Array[Attribute]:
	get:
		# NOTE maybe cache this
		var array: Array[Attribute]
		array.assign(find_children("*", "Attribute", true, false))
		return array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("AbilitySystems")

func add_effect(effect: EffectResource):
	var node = Effect.new(effect)
	node.trigger_requested.connect(_on_effect_application_requested)
	node.removal_requested.connect(_on_effect_removal_requested)
	add_child(node)


func _apply_effect(effect: EffectResource):
	for modifier in effect.modifiers:
		var attribute_name = Attribute.str(modifier.attribute)
		var attribute: Attribute = get_node(attribute_name) as Attribute
		if attribute:
			attribute.add(modifier.magnitude)

func _remove_effect(effect: EffectResource):
	print("TODO implement effect removal (", effect.name, ")")


#region Signal handlers
func _on_effect_application_requested(effect: EffectResource):
	_apply_effect(effect)

func _on_effect_removal_requested(effect: EffectResource):
	_remove_effect(effect)
#endregion