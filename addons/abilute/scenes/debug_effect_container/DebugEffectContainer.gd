extends HBoxContainer

@export var _name: Label
@export var _duration: Label

var _effect: Effect

var effect: Effect:
	set(value):
		_register(value)

#region Overrides
func _process(delta: float) -> void:
	if _effect:
		_duration.text = "(%1.1f)" % _effect.time_left()
#endregion

#region Private
func _register(new_effect: Effect):
	_effect = new_effect
	
	_effect.tree_exiting.connect(_on_effect_tree_exiting)
	
	_name.text = _effect.name
#endregion

#region Signal handlers
func _on_effect_tree_exiting():
	queue_free()
#endregion
