@tool
class_name AttributeResource extends Resource

enum Kind {
	Health,
	Stamina,
	Mana
}

@export var kind: Kind
@export var base_value: float = 100	
