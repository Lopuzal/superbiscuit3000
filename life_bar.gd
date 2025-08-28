extends ProgressBar

var player_life: float = 100.0
var player_max_life: float = 100.0

func _ready() -> void:
	get_tree().get_first_node_in_group("player").life_changed.connect(_on_player_life_changed)
	get_tree().get_first_node_in_group("player").max_life_changed.connect(_on_player_max_life_changed)
	update_color()

func _on_player_max_life_changed(max_life:float) -> void:
	player_max_life = max_life
	update_color()

func _on_player_life_changed(life:float) -> void:
	player_life = life
	update_color()

func update_color() -> void:
	var player_life_ratio: float = player_life / player_max_life
	value = player_life_ratio

	var new_stylebox: StyleBoxFlat = StyleBoxFlat.new()
	new_stylebox.bg_color = Color((1 - player_life_ratio), 0.5, 0)
	add_theme_stylebox_override("fill", new_stylebox)
	print(player_life_ratio)
