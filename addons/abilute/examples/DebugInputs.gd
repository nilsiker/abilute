extends Label

@export var target: AbiluteComponent
@export var damage_effect: BaseEffect
@export var stamina_effect: BaseEffect
@export var heal_effect: BaseEffect
@export var purge_effect: BaseEffect

#region Overrides
func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventKey or event.is_released(): return

	if event.keycode == KEY_F:
		target.add_effect(damage_effect)
	elif event.keycode == KEY_G:
		target.add_effect(stamina_effect)
	elif event.keycode == KEY_H:
		target.add_effect(heal_effect)
	elif event.keycode == KEY_P:
		target.add_effect(purge_effect)
#endregion

#region Signal handlers
func _on_abilute_debug_hud_ability_system_changed(ability_system: AbiluteComponent) -> void:
	target = ability_system
#endregion