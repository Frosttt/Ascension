class_name PlayerCamera
extends Camera2D


@export_range(0.0, 1.0) var mouse_weight: float = 0.35
@export var max_offset: float = 300.0
@export var follow_speed: float = 8.0


func initialize(is_local: bool) -> void:
	enabled = is_local
	set_process(is_local)

	if is_local:
		make_current()


func _process(delta: float) -> void:
	var viewport_size: Vector2= get_viewport_rect().size
	var viewport_center: Vector2 = viewport_size * 0.5
	var mouse_position: Vector2 = get_viewport().get_mouse_position()

	# Approximately -1 to 1 on each axis.
	var mouse_direction : Vector2 = (mouse_position - viewport_center) / viewport_center
	mouse_direction = mouse_direction.limit_length(1.0)

	var desired_offset : Vector2 = mouse_direction * max_offset * mouse_weight

	position = position.lerp(
		desired_offset,
		1.0 - exp(-follow_speed * delta)
	)