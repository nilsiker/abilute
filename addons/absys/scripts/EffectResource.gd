class_name EffectResource extends Resource

enum Kind {
	Instant,
	Duration,
	Infinite
}

@export var kind: Kind
@export var modifiers: Array[Modifier]
@export var duration: float
@export var period: float
