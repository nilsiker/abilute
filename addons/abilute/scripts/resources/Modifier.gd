@tool
class_name Modifier extends Resource

enum Operation {
	Add,
	Multiply,
	Override
}

@export var attribute: Attribute.Kind
@export var operation: Operation
@export var magnitude: float