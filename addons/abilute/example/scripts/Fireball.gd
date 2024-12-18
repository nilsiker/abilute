extends Area2D

var velocity: Vector2 = Vector2.ZERO
var on_body_entered: Callable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_entered.connect(func(b): queue_free())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta
