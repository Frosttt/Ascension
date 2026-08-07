class_name Weapon
extends Node2D

@onready var hitbox: Hitbox2D = $Hitbox

@export var attack_timer: Timer

func reset() -> void:
	hitbox.deactivate()

func _ready() -> void:
	reset()
	if (attack_timer != null):
		attack_timer.timeout.connect(attack_over)

func attack() -> void:
	if (attack_timer != null && attack_timer.is_stopped()):
		hitbox.activate()
		attack_timer.start()

	
func attack_over() -> void:
	hitbox.deactivate()
	print("Off")