extends CharacterBody2D

signal health_updated(value: float)
signal health_max_updated(value: float)
signal stamina_updated(value: float)
signal stamina_max_updated(value: float)

const SPEED = 200.0
const JUMP_VELOCITY = -200.0

@export var abilute: AbiluteComponent


func _ready() -> void:
	get_tree().current_scene.get_node("PlayerChannel").broadcast_player_ready(self)
	abilute.attribute_value_changed.connect(_on_attribute_value_changed)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_attribute_value_changed(data: Attribute.ChangeData):
	match data.attribute.attribute:
		"Health":
			health_updated.emit(data.new_value)
			if data.new_value <= 0:
				if not get_tree(): return
				get_tree().current_scene.get_node("PlayerChannel").die()	#
		"Stamina":
			stamina_updated.emit(data.new_value)
		"StaminaMax":
			stamina_max_updated.emit(data.new_value)
		"HealthMax":
			health_max_updated.emit(data.new_value)
		_: push_warning("attribute listener not implemented")
