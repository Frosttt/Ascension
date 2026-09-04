class_name Hitbox2D
extends Area2D


@export var damage: int = 10
@export var instigator: Node

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	if (instigator == null):
		instigator = owner;

func activate() -> void:
	print(activate)
	monitoring = true;

func deactivate() -> void:
	monitoring = false;

func _on_area_entered(area: Area2D) -> void:
	# TODO: Add an instigator so we know who deals damage. Do not allow self damage unless explicitely
	if area is Hurtbox2D:
		area.on_hit(self);




