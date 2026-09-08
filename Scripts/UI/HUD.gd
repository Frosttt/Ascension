class_name PlayerHUD
extends Control

var _player: PlayerCharacter
@onready var pause_menu: PauseMenu = $PlayerMenus/PauseMenuContainer/PauseMenu
@export var _health_bar: HealthBar

func bind_local_player(local_player: PlayerCharacter) -> void:
	if (local_player == null):
		return
	_player = local_player
	
	if (_health_bar != null):
		_health_bar.bind_health(_player.get_node("HealthComponent"))


func _ready() -> void:
	pause_menu.visible = false;

func toggle_pause_menu() -> void:
	if (get_tree().paused):
		close_pause_menu()
	else:
		open_pause_menu()

func open_pause_menu() -> void:
	pause_menu.visible = true;
	get_tree().paused = true;
	pause_menu.on_menu_closed.connect(close_pause_menu)

func close_pause_menu() -> void:
	pause_menu.visible = false;
	get_tree().paused = false
	pause_menu.on_menu_closed.disconnect(close_pause_menu)
