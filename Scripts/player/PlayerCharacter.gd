class_name PlayerCharacter
extends CharacterController


@onready var weaponHand: Node2D = $WeaponPivot
@onready var camera: PlayerCamera = $Camera2D

@onready var _player_hud: PlayerHUD = $PlayerHUD
var _dash_pressed: bool = false;

# networking
var peer_id: int
var _locally_controlled: bool = false;


func _ready() -> void:
	peer_id = name.to_int()
	set_multiplayer_authority(peer_id)
	camera.initialize(is_multiplayer_authority());
	if (starting_weapon):
		equip_weapon(starting_weapon)
	
	# TODO: SIngleplayer v. Multiplayer switch
	if (_player_hud != null):
		_player_hud.bind_local_player(self)

func _init() -> void:
	pass


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _input(event: InputEvent) -> void:
	if (!is_locally_controlled()): return;
	
	if (event.is_action_pressed("Light_Attack")):
		if (heldWeapon != null):
			heldWeapon.attack();
	
	if (event.is_action_pressed("Dash") && moveComponent.can_dash()):
		_dash_pressed = true

func _process(_delta: float) -> void:
	if (!is_locally_controlled()): return;

	if (heldWeapon.is_attacking() == false):
		_rotate_weapon_pivot()

func _physics_process(delta: float) -> void:
	# Probably move this to it's own component later

	if (!is_locally_controlled()): return;

	var input_direction: Vector2 = Input.get_vector(
		"Move_Left", 
		"Move_Right", 
		"Move_Up", 
		"Move_Down")
	
	if (faceDirection == MovementComponent.Direction.LEFT):
		sprite.scale.x = -abs(sprite.scale.x)
	elif (faceDirection == MovementComponent.Direction.RIGHT):
		sprite.scale.x = abs(sprite.scale.x)

	if (_dash_pressed && moveComponent.can_dash()):
		moveComponent.Dash(input_direction)
		_dash_pressed = false
	
	velocity = moveComponent.CalculateVelocity(velocity, input_direction, delta)

	move_and_slide()


func equip_weapon(weapon_scene: PackedScene) -> void:
	super.equip_weapon(weapon_scene);
	weaponHand.add_child(heldWeapon)
	heldWeapon.set_wielder(self)
	
func _rotate_weapon_pivot() -> void:
	# TODO: Implement for controller pivot
	# Ignore if right thumbsstick isnt aiming, fallback to move direction
	var mouse_pos: Vector2 = get_global_mouse_position()
	var aim: Vector2 = mouse_pos - global_position;
	var aim_dir: Vector2 = (aim).normalized()
	weaponHand.position = aim_dir * 10;
	weaponHand.rotation = aim_dir.angle() + PI / 2.0

	faceDirection = MovementComponent.get_cardinal_direction(aim_dir)


func is_locally_controlled() -> bool:
	return _locally_controlled

func set_local_control(enabled: bool) -> void:
	_locally_controlled = true;
	camera.enabled = true;
