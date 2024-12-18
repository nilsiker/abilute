class_name AbiluteDebugHUD extends VBoxContainer

const DebugAttributeContainer = preload("res://addons/abilute/scenes/debug_attribute_container/debug_attribute_container.tscn")
const DebugEffectContainer = preload("res://addons/abilute/scenes/debug_effect_container/debug_effect_container.tscn")
const DebugAbilityContainer = preload("res://addons/abilute/scenes/debug_ability_container/debug_ability_container.tscn")


@export var _active: AbiluteComponent
@export var _inspected_label: RichTextLabel
@export var _attributes: VBoxContainer
@export var _effects: VBoxContainer
@export var _abilities: VBoxContainer

var _system_index = 0

#region Overrides
func _ready() -> void:
	_update_selected_system()
#endregion

#region Attributes
func _refresh_attributes() -> void:
	_clear_attributes()
	if not _active: return
	for attribute in _active.find_children("*", "Attribute", true, false):
		_add_attribute(attribute)

func _add_attribute(attribute: Attribute) -> void:
	var node = DebugAttributeContainer.instantiate()
	node.attribute = attribute
	_attributes.add_child(node)

func _clear_attributes() -> void:
	_attributes.get_children().map(func(c): c.queue_free())
#endregion


#region Effects
func _refresh_effects() -> void:
	_clear_effects()
	if not _active: return
	for effect in _active.find_children("*", "Effect", true, false):
		_add_effect(effect)

func _add_effect(effect: Effect) -> void:
	var node = DebugEffectContainer.instantiate()
	node.effect = effect
	_effects.add_child(node)

func _clear_effects() -> void:
	_effects.get_children().map(func(c): c.queue_free())
#endregion


#region Abilities
func _refresh_abilities() -> void:
	_clear_abilities()
	if not _active: return
	for ability in _active.find_children("*", "Ability", true, false):
		_add_ability(ability)

func _add_ability(ability: Ability) -> void:
	var node = DebugAbilityContainer.instantiate()
	node.ability = ability
	_abilities.add_child(node)
	
func _clear_abilities() -> void:
	_abilities.get_children().map(func(c): c.queue_free())
#endregion


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventKey or event.is_released(): return

	if event.keycode == KEY_PAGEUP:
		_system_index += 1
		_system_index %= get_tree().get_node_count_in_group(Abilute.GROUP_NAME)
		_update_selected_system()
	elif event.keycode == KEY_PAGEDOWN:
		_system_index -= 1
		_system_index %= get_tree().get_node_count_in_group(Abilute.GROUP_NAME)
		_update_selected_system()

func _update_selected_system():
	if _active:
		_active.effect_added.disconnect(_on_effect_added)

	_active = get_tree().get_nodes_in_group(Abilute.GROUP_NAME)[_system_index]
	_active.effect_added.connect(_on_effect_added)

	_inspected_label.text = "[b]{1} ({0})[/b]".format([_active.name, _active.get_parent().name])
	_refresh_attributes()
	_refresh_effects()
	_refresh_abilities()


#region Signal handlers
func _on_effect_added(effect: Effect):
	_add_effect(effect)
func _on_ability_added(effect: Effect):
	_add_effect(effect)
#endregion