class_name MovementComponent
extends Node

@export var max_speed: float = 300.0
@export var acceleration: float = 1200.0
@export var deceleration: float = 1600.0

var _move_state: MoveState = MoveState.NORMAL
var _previous_move_state = MoveState.NORMAL

# Dash
var _dash_allowed: bool = false
@export var dash_allowed_immediate: bool = true;
@export var dash_cooldown: float = 3.0
@export var dash_duration: float = .5; # Duration in seconds
var dash_duration_timer: Timer
var dash_cooldown_timer: Timer
var _dash_direction: Vector2
@export var dash_distance: float = 100;
var _dash_acceleration: float = 0
var _dash_velocity: float = 0 

signal dash_finished()


enum Direction { RIGHT, UP, LEFT, DOWN }

enum MoveState { NORMAL, DASH, IMMOBILE}

func _ready() -> void:
	if (dash_allowed_immediate):
		enable_dash(true)


func CalculateVelocity(current_velocity: Vector2, input_direction: Vector2, delta: float) -> Vector2:
	var target_velocity: Vector2 = Vector2.ZERO
	var change: float = 0
	
	if (_move_state == MoveState.NORMAL):
		target_velocity = input_direction * max_speed
		change = acceleration

		if (input_direction.is_zero_approx()):
			change = deceleration
	
	if (_move_state == MoveState.DASH):
		target_velocity = _dash_direction * _dash_velocity
		change = _dash_acceleration
	
	return current_velocity.move_toward(target_velocity, change * delta)


static func get_cardinal_direction(input_direction: Vector2) -> Direction:
	var angle : float= fposmod(input_direction.angle(), TAU)

	if angle < PI / 4.0 or angle >= 7.0 * PI / 4.0:
		return Direction.RIGHT

	if angle < 3.0 * PI / 4.0:
		return Direction.DOWN

	if angle < 5.0 * PI / 4.0:
		return Direction.LEFT

	return Direction.UP

func enable_dash(enable: bool) -> bool:
	_dash_allowed = enable;
	if (enable):
		# Instantiate timers if they don't exist yet. Cache them just in case we re-enable it
		if (dash_duration_timer == null):
			dash_duration_timer = Timer.new()
			dash_duration_timer.name = "DashDurationTimer"
			dash_duration_timer.one_shot = true
			dash_duration_timer.wait_time = dash_duration
			dash_duration_timer.timeout.connect(_dash_finished)
			add_child(dash_duration_timer)
			# connect  stuff
		if (dash_cooldown_timer == null):
			dash_cooldown_timer = Timer.new()
			dash_cooldown_timer.name = "DashCooldownTimer"
			dash_cooldown_timer.one_shot = true
			dash_cooldown_timer.wait_time = dash_cooldown
			add_child(dash_cooldown_timer)
	return enable

func reset_timers(broadcastStop: bool) -> void:
# TODO: consider helper for timer manipulation/extension
	if (dash_duration_timer):
		dash_duration_timer.stop()
		if (broadcastStop):
			dash_duration_timer.timeout.emit();
	
	if (dash_cooldown):
		dash_duration_timer.stop()
		if (broadcastStop):
			dash_duration_timer.timeout.emit()


func can_dash() -> bool:
	return _dash_allowed && dash_cooldown_timer.is_stopped()

func _dash_finished() -> void:
	change_move_state(MoveState.NORMAL)
	dash_finished.emit()


func change_move_state(new_state: MoveState) -> MoveState:
	_previous_move_state = _move_state
	_move_state = new_state;
	# TODO: implement event for changing move state
	return _move_state

func Dash(normalized_input_vector: Vector2) -> void:
	# TODO: consider duration variable
	# Distance = .5 * acceleration * T^2
	# velocity = speed
	if (!can_dash()):
		return
	change_move_state(MoveState.DASH)
	_dash_acceleration = (dash_distance * 2) / (dash_duration * dash_duration)
	_dash_velocity = (dash_distance * 2) / dash_duration
	_dash_direction = normalized_input_vector
	dash_duration_timer.start()
	dash_cooldown_timer.start()
