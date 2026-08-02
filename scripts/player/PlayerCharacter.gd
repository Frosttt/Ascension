class_name PlayerCharacter
extends CharacterBody2D

@onready var moveComponent: MovementComponent = $MovementComponent

func _ready() -> void:
	pass

func _init() -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Probably move this to it's own component later

	var inputDirection: Vector2 = Input.get_vector(
		"MoveLeft", 
		"MoveRight", 
		"MoveUp", 
		"MoveDown")
	velocity = moveComponent.CalculateVelocity(velocity, inputDirection, delta)

	move_and_slide()
