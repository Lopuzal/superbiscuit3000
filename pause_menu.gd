extends ColorRect


func _on_continue_pressed() -> void:
	get_tree().paused = not get_tree().paused
	hide()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	if visible:
		$VBoxContainer/Continue.grab_focus()
