extends Label

@export var target: AbiluteComponent
@export var damage_effect: BaseEffect
@export var stamina_effect: BaseEffect
@export var heal_effect: BaseEffect
@export var stamina_regen_block_effect: BaseEffect

#region Overrides
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_damage"):
		target.add_effect(damage_effect)
	elif event.is_action_pressed("debug_fatigue"):
		target.add_effect(stamina_effect)
	elif event.is_action_pressed("debug_heal"):
		target.add_effect(heal_effect)
#endregion

#region Signal handlers
func _on_abilute_debug_hud_ability_system_changed(ability_system: AbiluteComponent) -> void:
	target = ability_system
#endregion