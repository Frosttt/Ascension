extends Node

const IP_ADDRESS: String = "localhost"
const PORT: int = 46250

var peer: ENetMultiplayerPeer

signal server_started()

func start_server() -> int:
	peer = ENetMultiplayerPeer.new()
	var error: int = peer.create_server(PORT)

	var localip: String = get_local_ip();
	print("[NetworkManager::Host]: Starting Server on %s:%d" %[localip, PORT])

	if (error != OK):
		print("[NetworkManager::Host]: Server initialization failed on %d:%d. Error Code: %d" %[localip, PORT, error])
		return error;
	
	multiplayer.multiplayer_peer = peer;
	print("[NetworkManager::Host]: Server has started on %s:%d with code: %d" %[localip, PORT, error])
	server_started.emit()
	return OK;

func start_client() -> int:
	peer = ENetMultiplayerPeer.new()
	var error: int = peer.create_client(IP_ADDRESS, PORT)
	print("[NetworkManager::Client]: Connecting %s:%d" %[IP_ADDRESS, PORT])

	if (error != OK):
		print("[NetworkManager::Client]: Client failed to connect to %s:%d" %[IP_ADDRESS, PORT])
		return error

	print("[NetworkManager::Client]: Successfully connected to %s:%d with code: %d" %[IP_ADDRESS, PORT, error])

	multiplayer.multiplayer_peer = peer;
	return OK
	
func get_local_ip() -> String:
	# Returns an array of all IP addresses bound to this machine
	var addresses: PackedStringArray = IP.get_local_addresses()
	
	for ip in addresses:
		# Filter for IPv4 local network addresses (commonly starting with 192.168. or 10.)
		if ip.to_ascii_buffer().size() > 0 and not ip.begins_with("127.") and not ":" in ip:
			return ip
			
	return "127.0.0.1" # Fallback to localhost if none found