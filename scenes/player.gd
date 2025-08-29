extends CharacterBody2D
signal life_changed
signal max_life_changed
##How much life the character can have
@export var max_life: float = 100.0:
	set(value):
		max_life = value
		max_life_changed.emit(max_life)

## The damage point each attack will deal
@export var attack_strength: float = 25

##How much life the character has at the moment
@export var life: float = 100.0:
	set(value):
		life = value
		life_changed.emit(life)
		if life <= 0:
			die()
		
@export var speed: float = 400.0

## The cooldown before each attack in sec
@export var attack_cooldown_sec: float = 1.0

#region private variables
## Used to know if the player can attack for cooldown
var _can_attack: bool = true
## Used to track if the player's weapon is colliding with the ennemy hitbox
var _colliding_hitbox : HitBox
#endregion 

func _ready() -> void:
	$AttackCooldownTimer.wait_time = attack_cooldown_sec
	$HurtBox/CollisionShape2D.disabled = true

func get_input() -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	look_at(get_global_mouse_position())
	velocity = input_direction * speed
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("attack") and _can_attack:
		$MeleeAttack.play("default")
		$AttackCooldownTimer.start()
		$HurtBox/CollisionShape2D.disabled = false
		_can_attack = false
	if _colliding_hitbox != null:
		_colliding_hitbox.apply_damage(attack_strength)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_collide(velocity * delta)

func die() -> void:
	print("player dead lol")
	queue_free()

func _on_hit_box_received_damage(damage_point: float) -> void:
	life -= damage_point
	print("player received damage, new hit points = ", life)


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area is HitBox :
		_colliding_hitbox = area as HitBox


func _on_hurt_box_area_exited(area: Area2D) -> void:
	_colliding_hitbox = null


func _on_attack_cooldown_timer_timeout() -> void:
	$AttackCooldownTimer.stop()
	_can_attack = true


func _on_melee_attack_animation_finished() -> void:
	$HurtBox/CollisionShape2D.disabled = true
