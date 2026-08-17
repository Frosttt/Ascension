class_name PlayerHUD
extends CanvasLayer

var _player: PlayerCharacter

func bind_local_player(local_player: PlayerCharacter) -> void:
	if (local_player == null):
		return