extends Area2D

@export var Ability = preload("res://addons/abilute/example/abilities/FireballAbility.gd")
@export var AbilityData = preload("res://addons/abilute/example/abilities/FireballAbilityData.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body.has_node("AbiluteComponent"):
		body.get_node("AbiluteComponent").grant_ability(Ability.new(AbilityData))
		queue_free()
