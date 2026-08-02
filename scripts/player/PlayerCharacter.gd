class_name PlayerCharacter
extends CharacterBody2D

@onready var moveComponent: MovementComponent = $MovementComponent

enum Direction { RIGHT, UP, LEFT, DOWN }

var faceDirection: Direction = Direction.DOWN

func _ready() -> void:
	pass

func _init() -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Probably move this to it's own component later

	var inputDirection: Vector2 = Input.get_vector(
		"Move_Left", 
		"Move_Right", 
		"Move_Up", 
		"Move_Down")
	
	if (not inputDirection.is_zero_approx()):
		faceDirection = GetCardinalDirection(inputDirection)
	
	velocity = moveComponent.CalculateVelocity(velocity, inputDirection, delta)

	move_and_slide()
	
	
func GetCardinalDirection(input_direction: Vector2) -> Direction:
	var angle := fposmod(input_direction.angle(), TAU)

	if angle < PI / 4.0 or angle >= 7.0 * PI / 4.0:
		return Direction.RIGHT

	if angle < 3.0 * PI / 4.0:
		return Direction.DOWN

	if angle < 5.0 * PI / 4.0:
		return Direction.LEFT

	return Direction.UP
