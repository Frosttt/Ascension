class_name MovementComponent
extends Node

@export var maxSpeed: float = 250.0
@export var acceleration: float = 1200.0
@export var deceleration: float = 1600.0

enum Direction { RIGHT, UP, LEFT, DOWN }

func CalculateVelocity(currentVelocity: Vector2, inputDirection: Vector2, delta: float) -> Vector2:
	var targetVelocity: Vector2 = inputDirection * maxSpeed
	var change: float = acceleration

	if (inputDirection.is_zero_approx()):
		change = deceleration
	
	return currentVelocity.move_toward(targetVelocity, change * delta)


static func GetCardinalDirection(input_direction: Vector2) -> Direction:
	var angle := fposmod(input_direction.angle(), TAU)

	if angle < PI / 4.0 or angle >= 7.0 * PI / 4.0:
		return Direction.RIGHT

	if angle < 3.0 * PI / 4.0:
		return Direction.DOWN

	if angle < 5.0 * PI / 4.0:
		return Direction.LEFT

	return Direction.UP
