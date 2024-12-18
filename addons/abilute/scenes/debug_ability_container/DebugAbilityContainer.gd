extends HBoxContainer

@export var _name: Label
@export var _action: Label

var _ability: Ability

var ability: Ability:
	set(value):
		_register(value)


#region Overrides
func _process(delta: float) -> void:
	if is_queued_for_deletion(): return
	modulate.a = 1.0 if _ability.can_activate() else 0.5
#endregion

#region Private
func _register(new_ability: Ability):
	_ability = new_ability
	
	_ability.tree_exiting.connect(_on_ability_tree_exiting)
	
	_name.text = _ability.name
	_action.text = "(%s)" % InputMap.action_get_events(_ability.action).pop_front().as_text().split(' ')[0]
	
#endregion

#region Signal handlers
func _on_ability_tree_exiting():
	queue_free()
#endregion
