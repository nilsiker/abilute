@tool
class_name Attribute extends Resource

static func str(kind: Attribute.Kind) -> String:
	return Kind.keys()[kind]

signal base_value_changed(value: float)

enum Kind {
	Health,
	Stamina,
	Mana
}

var _base_value: float = 100

@export var kind: Kind
@export var base_value: float = 100	:
	get: return _base_value
	set(value): 
		_base_value = value
		base_value_changed.emit(_base_value)