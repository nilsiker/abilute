@tool
class_name AttributeData extends Resource

var attribute: StringName
var max_attribute: StringName = Abilute.ATTRIBUTE_NONE
var base_value: float = 100
var allow_negative: bool = false

func _get_property_list() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	list.append(Abilute.ATTRIBUTE_PROPERTY)
	list.append(Abilute.MAX_ATTRIBUTE_PROPERTY)
	list.append({"name": "base_value", "type": TYPE_FLOAT})
	list.append({"name": "allow_negative", "type": TYPE_BOOL})
	return list