@tool
class_name Abilute extends EditorPlugin

const GROUP_NAME = "AbiluteComponents"
const ATTRIBUTES_SETTING = "Abilute/Attributes"

static var ATTRIBUTE_PROPERTY: Dictionary:
	get: return {
		"name": "attribute",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(ProjectSettings.get(Abilute.ATTRIBUTES_SETTING)),
	}

func _enable_plugin() -> void:
	if not ProjectSettings.has_setting(ATTRIBUTES_SETTING):
		ProjectSettings.set_setting(ATTRIBUTES_SETTING, [&"example_attribute"])


func _disable_plugin() -> void:
	pass