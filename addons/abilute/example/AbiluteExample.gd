extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false


func _on_player_died():
	if get_tree():
		get_tree().paused = true
		$UI/Margins.visible = false
		$UI/GameOver.visible = true


func _on_try_again_button_pressed() -> void:
	get_tree().reload_current_scene()
