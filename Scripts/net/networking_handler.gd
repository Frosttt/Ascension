extends Node

const IP_ADDRESS: String = "localhost"
const PORT: int = 46250

var peer: ENetMultiplayerPeer

signal server_started()

func start_server() -> int:
	peer = ENetMultiplayerPeer.new()
	var error: int = peer.create_server(PORT)

	if (error != OK):
		return error;
	
	multiplayer.multiplayer_peer = peer;
	server_started.emit()
	return OK;

func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer;
