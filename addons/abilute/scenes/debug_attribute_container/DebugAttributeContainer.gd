@tool extends HBoxContainer

var _label: Label
var _value: Label
var _base: Label

@export var _attribute: Attribute

func _init(attribute: Attribute = null):
	if not attribute: return
	_attribute = attribute
	var label = Label.new()
	label.text = attribute.name
	var value = Label.new()
	value.text = str(attribute.value)
	var base = Label.new()
	base.text = "(%s)" % attribute.base_value 

	_label = label
	_value = value
	_base = base
	
	add_child(label)
	add_child(value)
	add_child(base)

	_attribute.base_value_changed.connect(_on_attribute_base_value_changed)
	_attribute.value_changed.connect(_on_attribute_value_changed)

func _exit_tree() -> void:
	if not _attribute: return
	_attribute.value_changed.disconnect(_on_attribute_value_changed)

func _on_attribute_value_changed(data: Attribute.ChangeData):
	_value.text = str(data.new_value)

func _on_attribute_base_value_changed(data: Attribute.ChangeData):
	_base.text = "(%s)" % data.new_value
