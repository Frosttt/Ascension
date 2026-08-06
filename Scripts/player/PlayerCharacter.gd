class_name PlayerCharacter
extends CharacterBody2D

@onready var moveComponent: MovementComponent = $MovementComponent
@onready var sprite: Sprite2D = $Sprite
@onready var weaponHand: Node2D = $WeaponPivot
@onready var camera: Camera2D = $Camera2D
@export var heldWeapon: Weapon

var faceDirection: MovementComponent.Direction = MovementComponent.Direction.DOWN

func _ready() -> void:
	pass

func _init() -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Light_Attack")):
		if (heldWeapon != null):
			heldWeapon.attack();

func _process(delta: float) -> void:
	_rotate_weapon_pivot()

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

	
	
func _rotate_weapon_pivot() -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var aim: Vector2 = mouse_pos - global_position;
	var aim_dir: Vector2 = (aim).normalized()
	weaponHand.position = aim_dir * 100;
	weaponHand.rotation = aim_dir.angle() + PI / 2.0