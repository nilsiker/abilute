@tool
class_name AttributeResource extends Resource

enum Kind {
	Health,
	Stamina,
	Mana
}

@export var attribute: Kind
@export var value: float = 100	