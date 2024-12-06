class_name Effect extends Node

@export var effect: EffectResource

signal modifiers_application_requested(effect: Array[Modifier])
signal modifiers_removal_requested(effect: Array[Modifier])

func _init(resource: EffectResource = null):
	effect = resource

#region Overrides
func _ready() -> void:
	match effect.kind:
		EffectResource.Kind.Instant: _trigger_instant()
		EffectResource.Kind.Duration: _trigger_duration()
		EffectResource.Kind.Infinite: _apply_infinite()
#endregion

#region Effect Triggers
func _trigger_instant():
	_request_modifier_application()
	queue_free()

func _trigger_duration():
	print("todo implement duration effect")

func _apply_infinite():
	if effect.period > 0.0:
		var timer = Timer.new()
		timer.wait_time = effect.period
		timer.autostart = true
		timer.one_shot = false
		timer.timeout.connect(_request_modifier_application)
		add_child(timer)
	else:
		_request_modifier_application()

func _request_modifier_application():
	modifiers_application_requested.emit(effect.modifiers)

func _request_modifier_removal():
	modifiers_removal_requested.emit(effect.modifiers)
#endregion
