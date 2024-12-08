class_name Modifier
extends Node
## Modifier is a container node for modifier data.
##
## It contains very little logic, but helps abstract the adding,
## getting and removing of modifiers on attribute nodes.

@export var data: ModifierData

func _init(data: ModifierData = null, destroy_signal: Signal = Signal()) -> void:
    name = "Modifier"
    self.data = data
    if destroy_signal: destroy_signal.connect(queue_free)

func modify(value: float) -> float:
    match data.operation:
        _: # Add
            return value + data.magnitude

