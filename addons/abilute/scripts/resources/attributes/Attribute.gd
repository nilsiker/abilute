@tool
class_name Attribute extends Resource

class ChangeData:
	var attribute: Attribute
	var old_value: float
	var new_value: float
	func _init(attribute: Attribute, old_value: float, new_value: float) -> void:
		self.attribute = attribute
		self.old_value = old_value
		self.new_value = new_value

signal attribute_changed(data: ChangeData)

var _base_value: float = 100
var _max_value: float = _base_value
var attribute: StringName
var base_value: float = 100:
	get: return _base_value
	set(value):
		var old_value = _base_value
		_base_value = value
		
		var data: ChangeData = ChangeData.new(self, old_value, _base_value)
		attribute_changed.emit(data)

var has_max_value: bool = false:
	get: return has_max_value
	set(value): 
		has_max_value = value
		notify_property_list_changed()

func set_base_value_override(override_value: float):
	_base_value = override_value

func _get_property_list() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	list.append(Abilute.ATTRIBUTE_PROPERTY)
	list.append({"name": "base_value", "type": TYPE_FLOAT})
	list.append({"name": "has_max_value", "type": TYPE_BOOL})
	if has_max_value:
		list.append({
			"name": "_max_value",
			"type": TYPE_FLOAT
		})

	return list