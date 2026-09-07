class_name HealthComponent
extends Node

signal health_changed(previous: int, current: int, max: int)
signal died(damageRecieved: int)

@export var max_health: int = 100
var current_health: int

func _ready() -> void:
	current_health = max_health;


func take_damage(amount: int, instigator: Node = null, _hitbox: Hitbox2D = null) -> int:
	var previousHp: int  = current_health
	
	if (instigator == owner):
		return current_health;

	current_health = maxi(current_health - amount, 0)
	health_changed.emit(previousHp, current_health, max_health)

	print("[%s]Health Changed: %s -> %s from instigator: %s" % [get_parent().name, previousHp, current_health, instigator.name]);
	
	if (current_health <= 0):
		died.emit(amount)

	return current_health

func Kill() -> void:
	var damage: int = current_health;
	current_health = 0
	died.emit(damage);

func Reset() -> void:
	current_health = max_health

func IsDead() -> bool:
	return current_health <= 0;

func IsAlive() -> bool:
	return current_health > 0;
