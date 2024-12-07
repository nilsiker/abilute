class_name Effect extends Node

@export var effect: EffectResource

signal application_requested(effect: Effect)
signal trigger_requested(effect: Effect)
signal removal_requested(effect: Effect)


#region Overrides
func _init(resource: EffectResource = null):
	effect = resource
	

func _ready() -> void:
	match effect.kind:
		EffectResource.Kind.Instant: _trigger_instant()
		EffectResource.Kind.Duration: _trigger_duration()
		EffectResource.Kind.Infinite: _trigger_infinite()
#endregion


#region Effect Triggers
func _trigger_instant():
	_request_trigger()
	queue_free()


func _trigger_duration():
	_request_application()
	_add_duration_timer()
	if effect.period > 0.0:
		_add_period_timer()
	else:
		_request_trigger()
	

func _trigger_infinite():
	_request_application()
	if effect.period > 0.0:
		_add_period_timer()
	else:
		_request_trigger()


#region Timer helpers
func _add_duration_timer():
	var duration_timer = Timer.new()
	duration_timer.wait_time = effect.period
	duration_timer.autostart = true
	duration_timer.one_shot = true
	duration_timer.timeout.connect(_request_removal)
	add_child(duration_timer)


func _add_period_timer():
	var period_timer = Timer.new()
	period_timer.wait_time = effect.period
	period_timer.autostart = true
	period_timer.one_shot = false
	period_timer.timeout.connect(_request_trigger)
	add_child(period_timer)
#endregion

#region Signal emitters
func _request_application():
	application_requested.emit(effect)


func _request_trigger():
	trigger_requested.emit(effect)


func _request_removal():
	removal_requested.emit(effect)
	queue_free()
	# NOTE we free here because on effect removal, we most likely always want to free the node also with potential timer children
#endregion
