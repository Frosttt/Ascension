extends Control
class_name MainMenu

@onready var _title: Label = $GlobalMenuContainer/MenuGroup/MainMenuVContainer/TitleText
@onready var _button_container: VBoxContainer= $GlobalMenuContainer/MenuGroup/MainMenuVContainer/MarginContainer/MenuButtonContainer
var _intro_tween: Tween;
@export var animation_duration: float= .75;
@export var stagger_delay: float = .05

func _ready() -> void:
	play_intro_animation()


func play_intro_animation() -> void:
	_title.offset_transform_position.x = -720;
	var buttonlist: Array[Node] = _button_container.get_children()

	if (_intro_tween != null):
		_intro_tween.kill();

	_intro_tween = create_tween()
	_intro_tween.set_parallel(true)
	
	_intro_tween.tween_property(
		_title,
		"offset_transform_position:x",
		0.0,
		animation_duration
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	for index: int in buttonlist.size():
		var control : Control = buttonlist.get(index) as Control
		if (!control.visible || !control.offset_transform_enabled):
			print_debug("Tween for object %s is not playing, did you forget to enable visibility or the offset_transform?" % control.name);
			continue
		control.offset_transform_position.x = -720;
		_intro_tween.tween_property(
			control,
			"offset_transform_position:x",
			0.0,
			animation_duration
		).set_delay((index + 1) * stagger_delay).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)



func _on_quit_button_button_up() -> void:
	AscensionGlobals.close_game(self);



func _on_solo_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Sandbox.tscn")
