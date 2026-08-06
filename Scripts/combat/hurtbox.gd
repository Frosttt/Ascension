class_name Hurtbox2D
extends Area2D

@onready var Health: HealthComponent

func _ready() -> void:
	#if (Health is not null):
		#pass
	pass

func on_hit(hitbox: Hitbox2D):
	Health.TakeDamage(hitbox.damage);
