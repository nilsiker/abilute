class_name Modifier extends Resource

enum Kind {
    Add,
    Multiply,
    Override
}

@export var attribute: Attribute.Kind
@export var kind: Kind
@export var magnitude: float
