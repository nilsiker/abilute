extends VBoxContainer

@export var target: AbilitySystem
@export var damage_effect: EffectResource
@export var stamina_effect: EffectResource
@export var heal_effect: EffectResource
@export var stamina_regen_block_effect: EffectResource


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_damage"):
		target.apply(damage_effect)
	elif event.is_action_pressed("debug_fatigue"):
		target.apply(stamina_effect)
	elif event.is_action_pressed("debug_heal"):
		target.apply(heal_effect)
	elif event.is_action_pressed("debug_stamina_regen_block"):
		target.apply(stamina_regen_block_effect)
