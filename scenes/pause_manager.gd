extends Node

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if NodeReferences.GUI.get_child(1).visible:
			NodeReferences.GUI.get_child(1).hide()
		else:
			NodeReferences.GUI.get_child(1).show()
		print(get_tree().get_current_scene())
