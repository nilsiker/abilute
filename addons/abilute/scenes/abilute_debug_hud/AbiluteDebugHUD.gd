class_name AbiluteDebugHUD extends CanvasLayer

signal ability_system_changed(ability_system: AbiluteComponent)

@export var _attribute_container: VBoxContainer
@export var _effects: Label
@export var _inspected_label: RichTextLabel
@export var _active_ability_system: AbiluteComponent:
	get: return get_tree().get_nodes_in_group(Abilute.GROUP_NAME)[_system_index]

var _system_index = 0
var DebugAttributeContainer = preload("res://addons/abilute/scenes/debug_attribute_container/DebugAttributeContainer.gd")


func _ready() -> void:
	_update_selected_system()


func _process(delta: float) -> void:
	_effects.text = "\n".join(_active_ability_system.effects.map(func(e):
		var title = e.data.resource_name if e.data.resource_name else e.data.resource_path
		if e.time_left() > 0:
			return "%s (%1.1f)" % [title, e.time_left()]
		else:
			return title
	))
	
func _refresh_attribute_containers():
	if not _attribute_container: return
	_attribute_container.get_children().map(func(c): c.queue_free())

	if not _active_ability_system: return
	for attribute in _active_ability_system.attributes:
		_add_attribute_debug_container(attribute)

func _update_selected_system():
	ability_system_changed.emit(_active_ability_system)
	_inspected_label.text = "[b]{0} ({1})[/b]".format([_active_ability_system.name, _active_ability_system.get_parent().name])
	_refresh_attribute_containers()

func _add_attribute_debug_container(attribute: Attribute):
	var node = DebugAttributeContainer.new(attribute)
	_attribute_container.add_child(node)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cycle_ability_system_up"):
		_system_index += 1
		_system_index %= get_tree().get_node_count_in_group(Abilute.GROUP_NAME)
		_update_selected_system()
	elif event.is_action_pressed("cycle_ability_system_down"):
		_system_index -= 1
		_system_index %= get_tree().get_node_count_in_group(Abilute.GROUP_NAME)
		_update_selected_system()
