extends ProgressBar


func _on_player_attribute_updated(value:float) -> void:
	self.value = value
	$Text/Value.text = str(value)


func _on_player_attribute_max_updated(value:float) -> void:
	max_value = value
	$Text/MaxValue.text = str(value)
