class_name EnemySpawner extends Marker2D

signal new_enemy_spawned

## time interval between to spawns in sec
@export var time_interval: float = 1.0
## limit the number of enemy spawn at the same time, -1 = no limit
@export var disable_after: int = -1

@export var is_disabled: bool = false :
	set(value) :
		is_disabled = value
		if is_disabled :
			$Timer.stop()
		else  :
			$Timer.start()

#region private variables
var _total_enemy_spawned: int = 0
#endregion

func _ready() -> void:
	$Timer.wait_time = time_interval
	$Timer.timeout.connect(_on_timer_timeout)
	if not is_disabled : 
		$Timer.start()

#region signal callbacks
func _on_timer_timeout() -> void:
	var new_enemy_instance: Enemy = SceneReferences.enemy_scene.instantiate()
	new_enemy_instance.global_position = global_position
	new_enemy_instance.add_to_group("enemies")
	add_sibling(new_enemy_instance)
	_total_enemy_spawned += 1
	
	if _total_enemy_spawned >= disable_after :
		is_disabled = true
#endregion
