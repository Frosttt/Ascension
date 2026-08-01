class_name HealthComponent
extends Node

signal health_changed(previous: int, current: int, max: int)
signal died(damageRecieved: int)

@export var MaxHealth: int = 100
var CurrentHealth: int

func _ready() -> void:
    CurrentHealth = MaxHealth;

func TakeDamage(amount: int) -> int:
    var previousHp: int  = CurrentHealth
    CurrentHealth = maxi(CurrentHealth - amount, 0)
    health_changed.emit(previousHp, CurrentHealth, MaxHealth)
    
    if (CurrentHealth <= 0):
        died.emit(amount)

    return CurrentHealth

func Kill() -> void:
    var damage: int = CurrentHealth;
    CurrentHealth = 0
    died.emit(damage);

func Reset() -> void:
    CurrentHealth = MaxHealth

func IsDead() -> bool:
    return CurrentHealth <= 0;

func IsAlive() -> bool:
    return CurrentHealth > 0;

