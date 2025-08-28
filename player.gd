extends CharacterBody2D
signal life_changed
signal max_life_changed

##How fast the character moves
@export var speed: float = 400.0

##How much life the character can have
@export var max_life: float = 100.0:
	set(value):
		max_life = value
		max_life_changed.emit(max_life)

##How much life the character has at the moment
@export var life: float = 100.0:
	set(value):
		life = value
		life_changed.emit(life)

func get_input() -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	look_at(get_global_mouse_position())
	velocity = input_direction * speed
	if velocity:
		life = life - 0.2
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_collide(velocity * delta)
