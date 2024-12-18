class_name Effect extends Node

@export var data: BaseEffect

signal application_requested(effect: Effect)
signal trigger_requested(effect: Effect)
signal removal_requested(effect: Effect)

#region Overrides
func _init(resource: BaseEffect = null):
	data = resource
	
	
func _ready() -> void:
	data.resource_name = data.resource_path.split('/')[-1].split('.')[0]
	name = data.resource_name
	if data is InfiniteEffect: _trigger_infinite()
	elif data is DurationEffect: _trigger_duration()
	else: _trigger_instant()
#endregion

func time_left() -> float:
	if data is DurationEffect:
		return $DurationTimer.time_left
	elif data is InfiniteEffect: return INF
	else: return 0.0

# TODO make this more typesafe?
func reset_timer():
	$DurationTimer.start()
	

#region Effect Triggers
func _trigger_instant():
	_request_trigger()
	queue_free()


func _trigger_duration():
	_request_application()
	_add_duration_timer()
	if data.period > 0.0:
		_add_period_timer()
	else:
		_request_trigger()

func _trigger_infinite():
	_request_application()
	if data.period > 0.0:
		_add_period_timer()
	else:
		_request_trigger()


#region Timer helpers
func _add_duration_timer():
	var duration_timer = Timer.new()
	duration_timer.name = "DurationTimer"
	duration_timer.wait_time = data.duration
	duration_timer.autostart = true
	duration_timer.one_shot = true
	duration_timer.timeout.connect(_request_removal)
	add_child(duration_timer)


func _add_period_timer():
	var period_timer = Timer.new()
	period_timer.name = "PeriodTimer"
	period_timer.wait_time = data.period
	period_timer.autostart = true
	period_timer.one_shot = false
	period_timer.timeout.connect(_request_trigger)
	add_child(period_timer)
#endregion

#region Signal emitters
func _request_application():
	application_requested.emit(self)


func _request_trigger():
	trigger_requested.emit(self)


func _request_removal():
	removal_requested.emit(self)
#endregion