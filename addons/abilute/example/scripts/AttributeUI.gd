extends VBoxContainer

const Player = preload("res://addons/abilute/example/scenes/player/Player.gd")

var _player: Player
var player: Player:
	get: return _player
	set(new_owner):
		if _player: 
			push_warning("cannot set new owning player")
			return
		_player = new_owner
		$HealthBar.update_value(_player.abilute.get_attribute_value("Health"))
		$HealthBar.update_max(_player.abilute.get_attribute_value("HealthMax"))
		$StaminaBar.update_value(_player.abilute.get_attribute_value("Stamina"))
		$StaminaBar.update_max(_player.abilute.get_attribute_value("StaminaMax"))
		_player.health_updated.connect($HealthBar.update_value)
		_player.health_max_updated.connect($HealthBar.update_max)
		_player.stamina_updated.connect($StaminaBar.update_value)
		_player.stamina_max_updated.connect($StaminaBar.update_max)

func _on_player_ready(player):
	self.player = player