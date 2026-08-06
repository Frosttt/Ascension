class_name Hitbox2D
extends Area2D

@export var damage: int = 10

func _ready() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox2D:
		area.on_hit(self);




