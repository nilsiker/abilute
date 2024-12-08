class_name DurationEffect extends BaseEffect

@export var duration: float
@export var period: float
@export var allow_reapply: bool = true

func _modifies_base() -> bool:
	return period > 0