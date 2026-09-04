class_name CharacterController
extends CharacterBody2D

@onready var moveComponent: MovementComponent = $MovementComponent
@onready var  healthComponent: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite
@export var starting_weapon: PackedScene = null

var heldWeapon: Weapon



var faceDirection: MovementComponent.Direction = MovementComponent.Direction.DOWN

func _ready() -> void:
	if (starting_weapon):
		equip_weapon(starting_weapon)
	

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	# Might be wise to have the child classes define this behavior
	pass


func equip_weapon(weapon_scene: PackedScene) -> void:
	var weapon: Weapon = weapon_scene.instantiate() as Weapon

	if (weapon == null):
		push_error("Supplied scene does not supply a weapon")
	
	heldWeapon = weapon;
	#weaponHand.add_child(heldWeapon)
	

