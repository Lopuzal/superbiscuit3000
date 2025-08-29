class_name Enemy extends CharacterBody2D

## Total hit points this enemy can receive before dying
@export var life: float = 100.0 :
	set(value) :
		life = value
		if life < 0.0 :
			_despawn()
## The speed of the enemy
@export var speed: float = 400.0
## The damage point each attack will deal
@export var attack_strength: float = 2.0
## The cooldown before each attack in sec
@export var attack_cooldown_sec: float = 1.0
## Cooldown before the enemy can take damage again
@export var damage_cooldown_sec: float = 5.0

#region private variables
## The targeted player
var _target_player: Node2D
## Used to know if the enemy can attack for cooldown
var _can_attack: bool = true
## Used to know if the enemy can take damage from player
var _can_receive_damage: bool = true
## Used to track if the enemy is colliding with the player hitbox
var _colliding_hitbox: HitBox
## Used to track if the enemy is colliding with the player hurtbox
var _colliding_hurtbox: HitBox
#endregion 

func _ready() -> void:
	$AttackCooldownTimer.wait_time = attack_cooldown_sec
	$DamageCooldownTimer.wait_time = damage_cooldown_sec
	_target_player = get_tree().get_first_node_in_group("player")
	if _target_player == null :
		printerr("No player found at ready")

func _process(_delta: float) -> void:
	if _colliding_hitbox != null and _can_attack :
		_can_attack = false
		$AttackCooldownTimer.start()
		_colliding_hitbox.apply_damage(attack_strength)

func _physics_process(_delta: float) -> void:
	if _target_player != null :
		velocity = (_target_player.global_position - global_position).normalized() * speed 
	else :
		velocity = Vector2(0.0, 0.0)
	
	move_and_slide()

func _despawn() -> void:
	queue_free()

#region signal callbacks
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area is HitBox :
		_colliding_hitbox = area as HitBox

func _on_hurt_box_area_exited(area: Area2D) -> void:
	_colliding_hitbox = null

func _on_hit_box_received_damage(damage_point: float) -> void:
	life -= damage_point
	$HitBox/CollisionShape2D.disabled = true
	$DamageCooldownTimer.start()

func _on_attack_cooldown_timer_timeout() -> void:
	$AttackCooldownTimer.stop()
	_can_attack = true

func _on_damage_cooldown_timer_timeout() -> void:
	$DamageCooldownTimer.stop()
	$HitBox/CollisionShape2D.disabled = false
#endregion
