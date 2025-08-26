class_name Enemy extends CharacterBody2D

@export var speed: float = 400.0
var target_player: Node2D

func _ready() -> void:
	target_player = get_tree().get_first_node_in_group("player")
	if target_player == null :
		printerr("No player found at ready")

func _physics_process(delta: float) -> void:
	if target_player != null :
		velocity = (target_player.global_position - global_position).normalized() * speed 
	else :
		velocity = Vector2(0.0, 0.0)
	
	move_and_slide()
