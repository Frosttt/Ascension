class_name PlayerCharacter
extends CharacterBody2D

@onready var moveComponent: MovementComponent = $MovementComponent
@onready var sprite: Sprite2D = $Sprite

var faceDirection: MovementComponent.Direction = MovementComponent.Direction.DOWN

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
		faceDirection = MovementComponent.GetCardinalDirection(inputDirection)
	
	if (faceDirection == MovementComponent.Direction.LEFT):
		sprite.scale.x = -abs(sprite.scale.x)
	elif (faceDirection == MovementComponent.Direction.RIGHT):
		sprite.scale.x = abs(sprite.scale.x)

	velocity = moveComponent.CalculateVelocity(velocity, inputDirection, delta)

	move_and_slide()
	
	
