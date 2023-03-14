@icon("./auto_recover_component.svg")
extends BaseComponent
class_name AutoRecoverComponent

## Give autorecovery capability to a [HealthComponent].

## Emitted when autorecovery is initiated.
signal autorecovery_initiated()

## Emitted when autorecovery starts.
signal autorecovery_started()

## Emitted when autorecovery stops.
signal autorecovery_stopped()

## Emitted when autorecovery is enabled or disabled.
signal autorecovery_enabled(status: bool)

## Emitted while autorecovery is waiting to start.
signal autorecovery_counting_down(time_left: float)

@export_group("Autorecovery", "autorecover_")

## The amount of autorecovery per autorecover_rate` tick.
@export_range(0.0, 1000.0, 0.01, "or_greater", "hide_slider") var autorecover_amount := 1.0:
	set(autorecover_amount_):
		autorecover_amount = max(0.0, autorecover_amount_)

## The rate of autorecovery (in seconds).
@export_range(0.0, 60.0, 0.01, "or_greater", "suffix:/s", "hide_slider") var autorecover_rate := 1.0:
	set(autorecover_rate_):
		autorecover_rate = max(0.0, autorecover_rate_)

## The delay before autorecovery starts (in seconds).
@export_range(0.0, 60.0, 0.01, "or_greater", "suffix:s", "hide_slider") var autorecover_delay := 1.0:
	set(autorecover_delay_):
		autorecover_delay = max(0.0, autorecover_delay_)

var _stat_component: StatComponent
var _recover_timer: Timer
var _delay_timer: Timer

func _ready() -> void:
	_stat_component = get_parent() as StatComponent
	assert(_stat_component, "AutoRecoverComponent must be a child of a StatComponent in %s." % [str(get_path())])
		
	_recover_timer = Timer.new()
	_delay_timer = Timer.new()
	_delay_timer.one_shot = true

	_recover_timer.timeout.connect(_on_recover_timer_timeout)
	_delay_timer.timeout.connect(_on_delay_timer_timeout)

	_stat_component.expended.connect(_on_stat_component_expended)
	_stat_component.exhausted.connect(_on_stat_component_exhausted)
	_stat_component.recovered_fully.connect(_on_stat_component_recovered_fully)

	was_enabled.connect(_on_was_enabled)
	was_disabled.connect(_on_was_disabled)
		
## Initiate the autorecovery process timer.
func initiate_autorecovery() -> void:
	if not enabled:
		return
	if _stat_component.is_maxed():
		stop_autorecovery()
		return
	
	_recover_timer.stop()
	_delay_timer.start(autorecover_delay)
	autorecovery_initiated.emit()
	
## Start autorecovery.
func start_autorecovery() -> void:
	if not enabled:
		return
	if _stat_component.is_maxed():
		stop_autorecovery()
		return

	_delay_timer.stop()
	_recover_timer.start(autorecover_rate)
	autorecovery_started.emit()

## Stop autorecovery.
func stop_autorecovery() -> void:
	_recover_timer.stop()
	_delay_timer.stop()
	autorecovery_stopped.emit()

# Recover when the recovery timer times out.
func _on_recover_timer_timeout() -> void:
	if enabled:
		_stat_component.recover(autorecover_amount)

# Start the recovery timer when the delay timer times out.
func _on_delay_timer_timeout() -> void:
	if enabled:
		start_autorecovery()

# When the [member _stat_component] is expended, initiate autorecovery.
func _on_stat_component_expended() -> void:
	initiate_autorecovery()

# When the [member _stat_component] is exhausted, initiate autorecovery.
func _on_stat_component_exhausted() -> void:
	initiate_autorecovery()

# When the [member _stat_component] is fully recovered, stop autorecovery.
func _on_stat_component_recovered_fully() -> void:
	stop_autorecovery()

# If the component is enabled, initiate autorecovery.
func _on_was_enabled() -> void:
	initiate_autorecovery()

# If the component is disabled, stop autorecovery.
func _on_was_disabled() -> void:
	stop_autorecovery()
