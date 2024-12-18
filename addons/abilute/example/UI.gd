extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_debug_ui"):
		$Margins/AbiluteDebugHUD.visible = not $Margins/AbiluteDebugHUD.visible
		$Margins/AttributeUI.visible = not $Margins/AttributeUI.visible