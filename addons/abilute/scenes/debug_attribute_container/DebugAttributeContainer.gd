extends HBoxContainer

@export var _name: Label
@export var _value: Label
@export var _base_value: Label

var _attribute: Attribute

var attribute: Attribute:
	get: return _attribute
	set(value):
		if _attribute:
			_unregister()
		_register(value)

#region Overrides
func _exit_tree() -> void:
	if _attribute: _unregister()
#endregion

#region Private
func _unregister():
	attribute.base_value_changed.disconnect(_on_attribute_base_value_changed)
	attribute.value_changed.disconnect(_on_attribute_value_changed)
	_attribute.tree_exiting.disconnect(queue_free)
	
	_attribute = null

func _register(new_attribute: Attribute):
	_attribute = new_attribute
	
	_attribute.base_value_changed.connect(_on_attribute_base_value_changed)
	_attribute.value_changed.connect(_on_attribute_value_changed)
	_attribute.tree_exiting.connect(queue_free)
	
	_name.text = _attribute.name
	_value.text = str(_attribute.value)
	_base_value.text = str(_attribute.base_value)


#endregion

#region Signal handlers
func _on_attribute_value_changed(data: Attribute.ChangeData):
	_value.text = str(data.new_value)

func _on_attribute_base_value_changed(data: Attribute.ChangeData):
	_base_value.text = "(%s)" % data.new_value
#endregion