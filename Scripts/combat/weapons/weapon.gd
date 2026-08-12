class_name Weapon
extends Node2D

@onready var hitbox: Hitbox2D = $Hitbox

@onready var attack_cooldown_timer: Timer = $AttackTimer
@onready var attack_hitbox_duration_timer: Timer = $HitboxDurationTimer
@onready var sprite: Sprite2D = $Sprite

func reset() -> void:
	hitbox.deactivate()
	if (sprite != null):
		sprite.visible = false

func _ready() -> void:
	reset()
	#if (attack_cooldown_timer != null):
		#attack_cooldown_timer.timeout.connect(attack_over)
	if (attack_hitbox_duration_timer != null):
		attack_hitbox_duration_timer.timeout.connect(attack_over)

func attack() -> void:
	if (attack_cooldown_timer != null && attack_cooldown_timer.is_stopped()):
		hitbox.activate()
		attack_cooldown_timer.start()
		attack_hitbox_duration_timer.start()
		if (sprite != null):
			sprite.visible = true
		
func attack_ready() -> bool:
	return attack_cooldown_timer != null && attack_cooldown_timer.is_stopped() && attack_hitbox_duration_timer != null && attack_hitbox_duration_timer.is_stopped()
	
func attack_over() -> void:
	hitbox.deactivate()
	if (sprite != null):
		sprite.visible = false
