extends Area2D

@export var add_on_enter: Array[BaseEffect]
@export var add_on_trigger: Array[BaseEffect]
@export var remove_on_exit: Array[BaseEffect]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if not body.has_node("AbiluteComponent"): return
		var abilute: AbiluteComponent = body.get_node("AbiluteComponent")
		for effect in add_on_trigger:	
			abilute.add_effect(effect)

		



func _on_body_entered(body: Node):
	if not body.has_node("AbiluteComponent"): return
	var abilute: AbiluteComponent = body.get_node("AbiluteComponent")
	for effect in add_on_enter:
		abilute.add_effect(effect)


func _on_body_exited(body: Node):
	if not body.has_node("AbiluteComponent"): return
	var abilute: AbiluteComponent = body.get_node("AbiluteComponent")
	for effect in remove_on_exit:
		abilute.remove_effect(effect)