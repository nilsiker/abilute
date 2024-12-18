extends ProgressBar

func update_value(new_value: float):
	self.value = new_value
	$Text/Value.text = str(new_value)

func update_max(new_max: float):
	max_value = new_max
	$Text/MaxValue.text = str(new_max)
