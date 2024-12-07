class_name AbiluteDebugHUD extends CanvasLayer

@export var _active_ability_system: AbilitySystem
@export var _attribute_container: VBoxContainer

var attribute_container_scene = preload("res://addons/abilute/scenes/debug_attribute_container/debug_attribute_container.tscn")

func _ready() -> void:
	_active_ability_system = get_tree().get_nodes_in_group("AbilitySystems")[0]
	_refresh_attribute_containers()

func _refresh_attribute_containers():
	if not _attribute_container: return
	_attribute_container.get_children().map(func(c): c.queue_free())

	if not _active_ability_system: return
	for attribute in _active_ability_system.attributes:
		_add_attribute_debug_container(attribute)


func _add_attribute_debug_container(attribute: Attribute):
	var node = attribute_container_scene.instantiate()
	
	_attribute_container.add_child(node)
	node.label = attribute.name
	node.value = str(attribute.attribute.value)
	attribute.value_changed.connect(func(f: float): node.value = str(f))
