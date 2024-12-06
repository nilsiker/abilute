class_name AbilitySystem extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("AbilitySystem")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply(effect: EffectResource):
	var node = Effect.new(effect)
	node.modifiers_application_requested.connect(_on_effect_modifiers_application_requested)
	node.modifiers_removal_requested.connect(_on_effect_modifiers_removal_requested)
	add_child(node)


func _on_effect_modifiers_application_requested(modifiers: Array[Modifier]):
	for modifier in modifiers:
		var attribute_name = Attribute.str(modifier.attribute)
		var attribute: Attribute = get_node(attribute_name) as Attribute
		if attribute:
			attribute.add(modifier.magnitude)

func _on_effect_modifiers_removal_requested(modifiers: Array[Modifier]):
	print("remove mods: ", modifiers)