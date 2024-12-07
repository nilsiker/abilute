@tool
class_name Modifier extends Resource

enum Operation {
	Add,
	Multiply,
	Override
}

@export var attribute: AttributeResource.Kind
@export var operation: Operation
@export var magnitude: float