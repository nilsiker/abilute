extends Label

const Player = preload("res://addons/abilute/example/scenes/player/Player.gd")

var tween: Tween

func _ready() -> void:
	modulate.a = 0

func fade_in():
	if tween and tween.is_running(): tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, (1- modulate.a) / 2)


func fade_out():
	if tween and tween.is_running(): tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, modulate.a / 2)


func _on_area_body_entered(body: Node2D) -> void:
	if body is Player:
		fade_in()


func _on_area_body_exited(body: Node2D) -> void:
	if body is Player:
		fade_out()
