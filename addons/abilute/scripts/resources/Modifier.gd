@tool
class_name Modifier extends Resource

enum Operation {
	Add = 1,
	Multiply = 0,
	Override = 2
}

var attribute: StringName
@export var operation: Operation = Operation.Add
@export var magnitude: float

func _get_property_list() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	list.append(Abilute.ATTRIBUTE_PROPERTY)
	return list