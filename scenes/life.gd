extends Label

func _ready() -> void:
	get_tree().get_first_node_in_group("player").life_changed.connect(_on_player_life_changed)

func _on_player_life_changed(life:float) -> void:
	text = str(int(life)) + " HP"
