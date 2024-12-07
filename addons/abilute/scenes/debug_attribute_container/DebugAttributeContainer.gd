@tool extends HBoxContainer

var _label: Label
var _value: Label

@export var _attribute: Attribute

func _init(attribute: Attribute = null):
	if not attribute: return
	_attribute = attribute
	var label = Label.new()
	label.text = attribute.name
	var value = Label.new()
	value.text = str(attribute.attribute.value)

	_label = label
	_value = value
	
	add_child(label)
	add_child(value)

	_attribute.value_changed.connect(_on_attribute_value_changed)

func _exit_tree() -> void:
	if not _attribute: return
	_attribute.value_changed.disconnect(_on_attribute_value_changed)

func _on_attribute_value_changed(value: float):
	_value.text = str(value)
