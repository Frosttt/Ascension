class_name HealthComponent
extends Node

signal healthChanged(previous: int, current: int, max: int)
signal died(damageRecieved: int)

@export var maxHealth: int = 100
var currentHealth: int

func _ready() -> void:
	currentHealth = maxHealth;

func TakeDamage(amount: int) -> int:
	var previousHp: int  = currentHealth
	currentHealth = maxi(currentHealth - amount, 0)
	healthChanged.emit(previousHp, currentHealth, maxHealth)
	
	if (currentHealth <= 0):
		died.emit(amount)

	return currentHealth

func Kill() -> void:
	var damage: int = currentHealth;
	currentHealth = 0
	died.emit(damage);

func Reset() -> void:
	currentHealth = maxHealth

func IsDead() -> bool:
	return currentHealth <= 0;

func IsAlive() -> bool:
	return currentHealth > 0;
