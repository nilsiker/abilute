class_name EffectResource extends Resource

enum Kind {
	Instant,
	Duration,
	Infinite
}

@export var kind: Kind
@export var tags: Tags
@export var modifiers: Array[Modifier]
@export var duration: float
@export var period: float
@export var success_effects: Array[EffectResource]
@export var failure_effects: Array[EffectResource]
