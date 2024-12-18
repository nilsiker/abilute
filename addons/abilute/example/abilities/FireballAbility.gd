extends Ability

const FireballEffect = preload("res://addons/abilute/example/effects/effect_fireball_damage.tres")
const Fireball = preload("res://addons/abilute/example/scripts/Fireball.gd")
var _fireball: PackedScene = preload("res://addons/abilute/example/scenes/abilities/fireball.tscn")
var _body: CharacterBody2D

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	super._ready()
	_body = _owner.get_parent() as CharacterBody2D
	
func try_activate() -> bool:
	if not can_activate(): return false
	
	var node: Fireball = _fireball.instantiate()
	node.global_position = _body.global_position
	node.velocity = direction * 400
	node.on_body_entered = on_body_entered
	add_child(node)
	
	return true

func on_body_entered(body: Node):
	if body.has_node("AbiluteComponent"):
		body.get_node("AbiluteComponent").add_effect(FireballEffect)
	else:
		print("no abilute component")
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		direction = Vector2.LEFT
	elif event.is_action_pressed("right"):
		direction = Vector2.RIGHT
		
		
