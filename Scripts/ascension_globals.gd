class_name AscensionGlobals
extends Node


static func reload_scene(instigator: Node) -> void:
	instigator.get_tree().reload_current_scene()

static func close_game(closer: Node) -> void:
	# Teardown for game online, saving etc

	# Finally quits
	closer.get_tree().quit(0)

static func return_to_main_menu(instigator: Node) -> void:
	instigator.change_scene_to_file("res://Scenes/UI/main_menu.tscn")