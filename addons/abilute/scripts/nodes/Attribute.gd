class_name Attribute extends Node

static func str(kind: AttributeResource.Kind) -> String:
	return AttributeResource.Kind.keys()[kind]

signal value_changed(float)
signal base_value_changed(float)

@export var data: AttributeResource

func add(val: float):
	data.base_value += val
	value_changed.emit(data.base_value)

func mul(val: float):
	data.base_value *= val
	value_changed.emit(data.base_value)

func add_base(val: float):
	data.base_value += val
	base_value_changed.emit(data.base_value)

func mul_base(val: float):
	data.base_value *= val
	base_value_changed.emit(data.base_value)
