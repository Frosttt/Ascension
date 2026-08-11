class_name PlayerCharacter
extends CharacterBody2D

@onready var moveComponent: MovementComponent = $MovementComponent
@onready var sprite: Sprite2D = $Sprite
@onready var weaponHand: Node2D = $WeaponPivot
@onready var camera: Camera2D = $Camera2D
@export var starting_weapon: PackedScene = null
var heldWeapon: Weapon

var _dash_pressed: bool = false;

# networking
var peer_id: int
var _locally_controlled: bool = false;

var faceDirection: MovementComponent.Direction = MovementComponent.Direction.DOWN

func _ready() -> void:
	peer_id = name.to_int()
	set_multiplayer_authority(peer_id)
	camera.enabled = is_multiplayer_authority()

	if (starting_weapon):
		equip_weapon(starting_weapon)


func _init() -> void:
	pass


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _input(event: InputEvent) -> void:
	if (!is_locally_controlled()): return;
	
	if (event.is_action_pressed("Light_Attack")):
		if (heldWeapon != null):
			heldWeapon.attack();
	
	if (event.is_action_pressed("Dash")):
		_dash_pressed = true

func _process(delta: float) -> void:
	if (!is_locally_controlled()): return;
	_rotate_weapon_pivot()

func _physics_process(delta: float) -> void:
	# Probably move this to it's own component later

	if (!is_locally_controlled()): return;

	var input_direction: Vector2 = Input.get_vector(
		"Move_Left", 
		"Move_Right", 
		"Move_Up", 
		"Move_Down")
	
	if (not input_direction.is_zero_approx()):
		faceDirection = MovementComponent.get_cardinal_direction(input_direction)
	
	if (faceDirection == MovementComponent.Direction.LEFT):
		sprite.scale.x = -abs(sprite.scale.x)
	elif (faceDirection == MovementComponent.Direction.RIGHT):
		sprite.scale.x = abs(sprite.scale.x)

	if (_dash_pressed && moveComponent.can_dash()):
		moveComponent.Dash(input_direction)
	
	velocity = moveComponent.CalculateVelocity(velocity, input_direction, delta)

	move_and_slide()


func equip_weapon(weapon_scene: PackedScene) -> void:
	var weapon: Weapon = weapon_scene.instantiate() as Weapon

	if (weapon == null):
		push_error("Supplied scene does not supply a weapon")
	
	heldWeapon = weapon;
	weaponHand.add_child(heldWeapon)
	
func _rotate_weapon_pivot() -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var aim: Vector2 = mouse_pos - global_position;
	var aim_dir: Vector2 = (aim).normalized()
	weaponHand.position = aim_dir * 100;
	weaponHand.rotation = aim_dir.angle() + PI / 2.0

func is_locally_controlled() -> bool:
	return _locally_controlled

func set_local_control(enabled: bool) -> void:
	_locally_controlled = true;
	camera.enabled = true;
