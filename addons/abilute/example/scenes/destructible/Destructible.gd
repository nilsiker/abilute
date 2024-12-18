extends StaticBody2D

@onready var abilute: AbiluteComponent = $AbiluteComponent 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	abilute.attribute_value_changed.connect(_on_abilute_attribute_value_changed)


var tween: Tween
func _on_abilute_attribute_value_changed(data: Attribute.ChangeData):
	if data.attribute.attribute == "Health":
		if tween and tween.is_running():
			tween.kill()
		tween = create_tween()
		modulate = Color.WHITE * 10
		tween.tween_property(self, "modulate", Color.WHITE, 0.1) 
		if data.new_value == 0:
			if tween and tween.is_running():
				tween.kill()
			tween = create_tween()
			modulate = Color.WHITE * 10
			tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.4)
			tween.tween_callback(queue_free) 
			
		
