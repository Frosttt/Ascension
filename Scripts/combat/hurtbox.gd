class_name Hurtbox2D
extends Area2D

@onready var Health: HealthComponent

func _ready() -> void:
	#if (Health is not null):
		#pass
	pass

func activate() -> void:
	monitoring = true;

func deactivate() -> void:
	monitoring = false;	

func on_hit(hitbox: Hitbox2D) -> void:
	if (Health):
		Health.TakeDamage(hitbox.damage);
