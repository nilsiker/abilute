@tool extends HBoxContainer

@onready var _label: Label = $Label
@onready var _value: Label = $Value

@export var label: String:
	get: return _label.text if _label else ""
	set(text): if _label: _label.text = text

@export var value: String:
	get: return _value.text if _value else ""
	set(text): if _label: _value.text = text