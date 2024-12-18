class_name Cue extends Node

@export var data: CueData

func _ready() -> void:
	for a in data.spawn_on_application:
		add_child(a.instantiate())
	for t in data.spawn_on_trigger:
		add_child(t.instantiate())
	for r in data.spawn_on_removal:
		add_child(r.instantiate())
