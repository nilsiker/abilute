class_name InfiniteEffect extends BaseEffect

@export var period: float

func _modifies_base() -> bool:
	return period > 0