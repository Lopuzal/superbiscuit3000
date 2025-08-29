extends CharacterBody2D

@export var hit_points: float = 100.0 :
	set(value):
		hit_points = value
		if hit_points <= 0 :
			die()
		
@export var speed: float = 400.0

func get_input() -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	look_at(get_global_mouse_position())
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_collide(velocity * delta)
	
func die() -> void:
	print("player dead lol")
	queue_free()

func _on_hit_box_received_damage(damage_point: float) -> void:
	hit_points -= damage_point
	print("player received damage, new hit points = ", hit_points)
