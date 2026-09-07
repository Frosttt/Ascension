class_name AscensionGlobals
extends Node



static func close_game(closer: Node) -> void:
	# Teardown for game online, saving etc

	# Finally quits
	closer.get_tree().quit(0)
