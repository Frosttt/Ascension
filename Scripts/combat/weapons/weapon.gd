class_name Weapon
extends Node2D

@onready var hitbox: Hitbox2D = $Hitbox

func reset() -> void:
	hitbox.deactivate()

func _ready() -> void:
	reset()
	
func attack() -> void:
	hitbox.activate()
	
