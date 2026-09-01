class_name PlayerHUD
extends Control

var _player: PlayerCharacter
@export var _health_bar: HealthBar

func bind_local_player(local_player: PlayerCharacter) -> void:
	if (local_player == null):
		return
	_player = local_player
	
	if (_health_bar != null):
		_health_bar.bind_health(_player.get_node("HealthComponent"))


	
