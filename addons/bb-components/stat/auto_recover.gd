@icon("./auto_recover.svg")
class_name BBAutoRecover
extends Node

## Give a [StatComponent] the ability to autorecover over time.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/auto_recover.md

# The autorecover rate which triggers autorecovery.
const __TRIGGER_LIMIT_AUTORECOVER_RATE := 0.0

## Emitted when autorecovery starts.
signal autorecovery_started()

## Emitted when autorecovery stops.
signal autorecovery_stopped()

## Emitted when autorecovery is enabled or disabled.
signal autorecovery_enabled(status : bool)

## Emitted while autorecovery is waiting to start.
signal autorecovery_counting_down(time_left : float)

## The [BBStat] to autorecover.
@export var stat_node:BBStat

## Whether autorecovery is enabled.  Initiate autorecovery if enabled.
@export var enabled := false:
	set(is_enabled):
		enabled = is_enabled
		autorecovery_enabled.emit(enabled)

		if enabled:
			call_deferred("__initiate_autorecovery")
		else:
			call_deferred("__prevent_autorecovery")
			call_deferred("__stop_autorecovery")

@export_group("Autorecovery", "autorecover_")

## The amount of autorecovery per autorecover_rate` tick.
@export var autorecover_amount := 0.0

## The rate of autorecovery (in seconds).
@export var autorecover_rate := 0.0

## The delay before autorecovery starts (in seconds).
@export var autorecover_delay := 0.0

# A timer to determine when autorecovery can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when autorecovery occurs.
@onready var __recovery_timer := %RecoveryTimer

func _ready() -> void:
	assert(stat_node, ("No stat_node:Stat component specified in %s. Select " +
		"one, or reparent this component as a child of a Stat component.") 
		% [str(get_path())])
	
	# Start the recovery timer when the delay timer times out.
	__delay_timer.timeout.connect(func():
		if enabled and autorecover_rate > __TRIGGER_LIMIT_AUTORECOVER_RATE:
			__start_autorecovery())

	# Recover when the recovery timer times out.
	__recovery_timer.timeout.connect(func():
		if enabled:
			stat_node.recover(autorecover_amount))
			
	# Stop autorecovery on expenditure, and restart the delay timer.
	stat_node.expended.connect(func(_amount:float):
		__stop_autorecovery()
		__initiate_autorecovery())
		
	# Stop autorecovery when the stat is fully restored.
	stat_node.recovered_fully.connect(func():
		__stop_autorecovery()
		__prevent_autorecovery())

# Initiate the autorecovery process timer.
func __initiate_autorecovery() -> void:
	if not enabled: return
	if stat_node.is_maxed(): return
	
	__delay_timer.start(autorecover_delay)
	
# Prevent the autorecovery process.
func __prevent_autorecovery() -> void:
	__delay_timer.stop()

# Start autorecovery.
func __start_autorecovery() -> void:
	if not enabled: return
	if stat_node.is_exhausted(): return

	__recovery_timer.start(autorecover_rate)
	autorecovery_started.emit()

# Stop autorecovery.
func __stop_autorecovery() -> void:
	__recovery_timer.stop()
	autorecovery_stopped.emit()

# Update the amount of time remaining on the delay timer.
func _process(_delta: float) -> void:
	if not __delay_timer.is_stopped():
		autorecovery_counting_down.emit(get_delay_time_remaining())

## Set the stat node.
func set_stat(new_stat : BBStat) -> void:
	stat_node = new_stat
	
## Get the stat node.
func get_stat() -> BBStat:
	return stat_node

## Set enabled.
func set_enabled(is_enabled : bool) -> void:
	enabled = is_enabled
	
## Get enabled.
func get_enabled() -> bool:
	return enabled
	
## Set the autorecovery amount.
func set_autorecover_amount(amount : float) -> void:
	autorecover_amount = amount

## Get the autorecovery amount.
func get_autorecover_amount() -> float:
	return autorecover_amount

## Set the autorecovery rate.
func set_autorecover_rate(rate : float) -> void:
	autorecover_rate = rate

## Get the autorecovery rate.
func get_autorecover_rate() -> float:
	return autorecover_rate

## Set the autorecovery delay.
func set_autorecover_delay(delay : float) -> void:
	autorecover_delay = delay

## Get the autorecovery delay.
func get_autorecover_delay() -> float:
	return autorecover_delay

## Enable autorecovery.
func enable() -> void:
	set_enabled(true)

## Disable autorecovery.
func disable() -> void:
	set_enabled(false)

## Return whether the component is enabled.
func is_enabled() -> bool:
	return get_enabled()

## Return the amount of time left before autorecovery commences (in seconds).
func get_delay_time_remaining() -> float:
	if not __delay_timer.is_stopped():
		return __delay_timer.time_left

	return 0.0

