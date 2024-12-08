class_name BaseEffect extends Resource

@export var modifiers: Array[Modifier]
@export var trigger_blocked_by: Array[BaseEffect]
@export var application_blocked_by: Array[BaseEffect]
@export var removes: Array[BaseEffect]
@export var success_effects: Array[BaseEffect]
@export var failure_effects: Array[BaseEffect]
