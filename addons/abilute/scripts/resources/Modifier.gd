@tool
class_name Modifier extends Resource

enum Operation {
	Add,
	Multiply,
	Override
}

var attribute: StringName
@export var operation: Operation
@export var magnitude: float

func _get_property_list() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	list.append(Abilute.ATTRIBUTE_PROPERTY)
	return list