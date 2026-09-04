class_name TestLevel
extends Node2D

@export var playerScene: PackedScene
@export var _play_local: bool = false;

@onready var playerList: Node2D = $Players
@onready var playerSpawn: Marker2D = $PlayerSpawn
@onready var multiPlayerSpawner: MultiplayerSpawner = $MultiplayerSpawner




func _ready() -> void:
	if (_play_local):
		var local_player: PlayerCharacter = SpawnPlayer()
		local_player.set_local_control(true)
	
	
func SpawnPlayer() -> PlayerCharacter:
	var player: PlayerCharacter= playerScene.instantiate() as PlayerCharacter
	if (player == null):
		push_error("The assigned player scene does not have a PlayerCharacter script!")
		return null
	playerList.add_child(player)
	player.global_position = playerSpawn.global_position
	return player
