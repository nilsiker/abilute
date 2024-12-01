class_name Attribute extends Node

enum Kind {
	Health,
	Stamina,
	Mana
}

static func str(kind: Kind) -> String:
	return Attribute.Kind.keys()[kind]

signal value_changed(float)
signal base_value_changed(float)

@export var kind: Kind
@export var attribute: AttributeResource

func add(val: float):
	attribute.value += val
	value_changed.emit(attribute.value)

func mul(val: float):
	attribute.value *= val
	value_changed.emit(attribute.value)

func add_base(val: float):
	attribute.base_value += val
	base_value_changed.emit(attribute.base_value)

func mul_base(val: float):
	attribute.base_value *= val
	base_value_changed.emit(attribute.base_value)
