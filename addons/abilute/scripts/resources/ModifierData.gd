@tool
class_name ModifierData extends Resource

enum Operation {
	Add = 1,
	Multiply = 2,
	Set = 3
}

@export var operation: Operation = Operation.Add
var attribute: StringName
var curve: Curve
var magnitude: float

func _get_property_list() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	list.append(Abilute.ATTRIBUTE_PROPERTY)
	list.append({
		"name": "magnitude",
		"type": TYPE_FLOAT
	})
	list.append({
		"name": "curve",
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "Curve"
	})
	return list