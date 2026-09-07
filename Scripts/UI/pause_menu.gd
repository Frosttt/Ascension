extends Control
class_name PauseMenu

signal menu_closed

func _ready() -> void:
	pass;

func close_menu() -> void:
	# handle unpause here or outside of this. Probably in some global controller
	menu_closed.emit()
	pass;

func _on_resume_button_button_up() -> void:
	close_menu()


func _on_quit_button_button_up() -> void:
	AscensionGlobals.close_game(self);
