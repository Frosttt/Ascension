extends Control
class_name PauseMenu

signal on_menu_closed

func _ready() -> void:
	pass;

func close_menu() -> void:
	# handle unpause here or outside of this. Probably in some global controller
	on_menu_closed.emit()
	pass;

func _on_resume_button_button_up() -> void:
	close_menu()


func _on_quit_button_button_up() -> void:
	close_menu()
	AscensionGlobals.close_game(self);


func _on_restart_button_button_up() -> void:
	close_menu()
	AscensionGlobals.reload_scene(self)


func _on_main_menu_button_button_up() -> void:
	close_menu()
	AscensionGlobals.return_to_main_menu(self)