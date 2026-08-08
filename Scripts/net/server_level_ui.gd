extends Control

signal online_started

func _on_server_pressed() -> void:
	NetworkHandler.start_server();
	online_started.emit()

func _on_client_pressed() -> void:
	NetworkHandler.start_client();