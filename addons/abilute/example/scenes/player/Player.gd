extends CharacterBody2D

signal died
signal health_updated(value: float)
signal health_max_updated(value: float)
signal stamina_updated(value: float)
signal stamina_max_updated(value: float)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var abilute: AbiluteComponent

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
				died.emit()
		"Stamina":
			stamina_updated.emit(data.new_value)
		"StaminaMax":
			stamina_max_updated.emit(data.new_value)
		"HealthMax":
			health_max_updated.emit(data.new_value)
		_: push_error("attribute listener not implemented")
