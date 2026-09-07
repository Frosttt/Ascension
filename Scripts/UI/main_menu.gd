extends Control
class_name MainMenu



func _on_quit_button_button_up() -> void:
	AscensionGlobals.close_game(self);



func _on_solo_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Sandbox.tscn")
