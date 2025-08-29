extends ColorRect


func _on_continue_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	if visible:
		$VBoxContainer/Continue.grab_focus()


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_toggle_music_toggled(toggled_on: bool) -> void:
	if toggled_on:
		NodeReferences.Music.play()
		print("Music is on!")
	else:
		NodeReferences.Music.stop()
		print("Music is off!")


func _on_music_bar_value_changed(value: float) -> void:
	NodeReferences.Music.volume_linear = value * 0.1

	if not NodeReferences.Music.playing:
		NodeReferences.Music.play()
		NodeReferences.ToggleMusic.button_pressed = true
