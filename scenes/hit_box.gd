class_name HitBox extends Area2D

signal received_damage(damage_point: float)

func apply_damage(damage_point: float) -> void:
	received_damage.emit(damage_point)
