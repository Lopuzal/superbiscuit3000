extends CharacterBody2D

@export var speed: float = 400.0

func get_input() -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	look_at(get_global_mouse_position())
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_collide(velocity * delta)
