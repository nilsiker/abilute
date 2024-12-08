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
@export var trigger_blocked_by: Array[EffectResource]
@export var application_blocked_by: Array[EffectResource]
@export var success_effects: Array[EffectResource]
@export var failure_effects: Array[EffectResource]
