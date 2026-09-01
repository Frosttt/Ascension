class_name HealthBar
extends ProgressBar


@onready var damage_bar_timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $DamageBar
@export var health_comp: HealthComponent
var change_value_tween: Tween
var opacity_tween: Tween

var prev_health: float = 0

func _ready() -> void:
	damage_bar_timer.timeout.connect(_on_timer_timeout)
	min_value = 0;
	max_value = 100;
	#value = 100;
	if (health_comp):
		bind_health(health_comp)


func bind_health(_healthComp: HealthComponent) -> void:
	health_comp = _healthComp

	max_value = health_comp.max_health
	value = health_comp.current_health
	prev_health = health_comp.max_health
	#modulate.a = 0.0
	damage_bar.max_value = health_comp.max_health
	damage_bar.value = health_comp.current_health
	health_comp.health_changed.connect(_on_binded_health_change)

	# Match Damage Bar too!
	damage_bar.value = health_comp.current_health
	


func _on_binded_health_change(_previous_health: int, current: int, _max_health: int) -> void:
	if (health_comp == null):
		return

	if current < 0:
		# do something if dead
		return
	
	#_change_opacity(1.0)
	#modulate.a = 1.0
	#await opacity_tween.finished
	
	value = current
	change_value_tween = create_tween()
	change_value_tween.finished.connect(damage_bar_timer.start)
	change_value_tween.tween_property(damage_bar, "value", current, .35).set_trans(Tween.TRANS_SINE)

func _on_timer_timeout() -> void:
	damage_bar.value = value

func _change_opacity(new_amount: float) -> void:
	if (opacity_tween):
		opacity_tween.kill()
	opacity_tween = create_tween()
	opacity_tween.tween_property(self, "modulate:a", new_amount, 0.12).set_tran(Tween.TRANS_SINE)
