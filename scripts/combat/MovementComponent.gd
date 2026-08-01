class_name MovementComponent
extends Node

@export var maxSpeed: float = 250.0
@export var acceleration: float = 1200.0
@export var deceleration: float = 1600.0

func CalculateVelocity(currentVelocity: Vector2, inputDirection: Vector2, delta: float) -> Vector2:
    var targetVelocity: Vector2 = inputDirection * maxSpeed
    var change: float = acceleration

    if (inputDirection.is_zero_approx()):
        change = deceleration
    
    return currentVelocity.move_toward(targetVelocity, change * delta)