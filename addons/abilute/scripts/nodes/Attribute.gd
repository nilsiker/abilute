class_name Attribute extends Node

signal base_value_changed(data: Attribute.ChangeData)
signal value_changed(data: Attribute.ChangeData)

@export var _data: AttributeData
var base_value: float:
	get: return _data.base_value
var value: float:
	get:
		var value = _data.base_value
		var mods = find_children("*", "Modifier", true, false)
		for mod in mods:
			value = mod.modify(base_value)
		if _max:
			value = min(_max.value, value)
		return value
var _max: Attribute

#region Overrides
func _init(data: AttributeData = null) -> void:
	_data = data
	name = _data.attribute
#endregion

#region Public
func init():
	if _data.max_attribute == Abilute.ATTRIBUTE_NONE: return
	_max = get_parent().get_node(str(_data.max_attribute))
	_max.value_changed.connect(_on_max_attribute_value_updated)

func add_base_modifier(modifier: Modifier):
	var old_base_value = base_value
	var old_value = value

	_data.base_value = modifier.modify(_data.base_value)
	if _max:
		_data.base_value = min(_data.base_value, _max.value)
	if not _data.allow_negative:
		_data.base_value = max(_data.base_value, 0)

	var base_data = Attribute.ChangeData.new(_data, old_base_value, base_value)
	base_value_changed.emit(base_data)

	var data = Attribute.ChangeData.new(_data, old_value, value)
	value_changed.emit(data)
	modifier.queue_free()


func add_modifier(modifier: Modifier):
	var old_value = value
	add_child(modifier)
	var data = Attribute.ChangeData.new(_data, old_value, value)
	value_changed.emit(data)
	modifier.tree_exited.connect(_on_modifier_tree_exited)
#endregion

#region Private
func _clamp_base_value():
	if _max:
		_data.base_value = min(_data.base_value, _max.value)
	if not _data.allow_negative:
		_data.base_value = max(_data.base_value, 0)
#endregion

#region Signal handlers
func _on_modifier_tree_exited():
	# NOTE this gives a faulty "old value", but its not really used
	var lying_data = Attribute.ChangeData.new(_data, value, value)
	value_changed.emit(lying_data)

func _on_max_attribute_value_updated(data: Attribute.ChangeData):
	 # NOTE this gives a faulty "old value", but its not really used
	_clamp_base_value()
	var lying_data = Attribute.ChangeData.new(_data, value, value)
	value_changed.emit(lying_data)
	var lying_base_data = Attribute.ChangeData.new(_data, base_value, base_value)
	value_changed.emit(lying_data)
	base_value_changed.emit(lying_base_data)
#endregion

#region Structs
class ChangeData:
	var attribute: AttributeData
	var old_value: float
	var new_value: float
	func _init(attribute: AttributeData, old_value: float, new_value: float) -> void:
		self.attribute = attribute
		self.old_value = old_value
		self.new_value = new_value
#endregion