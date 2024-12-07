extends Label

@export var target: AbilitySystem
@export var damage_effect: EffectResource
@export var stamina_effect: EffectResource
@export var heal_effect: EffectResource
@export var stamina_regen_block_effect: EffectResource

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
func _on_abilute_debug_hud_ability_system_changed(ability_system: AbilitySystem) -> void:
	target = ability_system
#endregion