class_name StatAutoRecover
extends Node

## A node to automatically recover a [Stat] node.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/StatAutoRecover.md

# The default autorecover amount.
const __DEFAULT_AUTORECOVER_AMOUNT := 0.0

# The default autorecover rate.
const __DEFAULT_AUTORECOVER_RATE := 0.0

# The default autorecover delay.
const __DEFAULT_AUTORECOVER_DELAY := 0.0

# The autorecover rate which triggers autorecovery.
const __TRIGGER_LIMIT_AUTORECOVER_RATE := 0.0

## Emitted when autorecovery starts.
signal autorecovery_started()

## Emitted when autorecovery stops.
signal autorecovery_stopped()

## Emitted when autorecovery is enabled or disabled.
signal autorecovery_enabled(status: bool)

## Emitted when autorecovery is about to begin.
signal autorecovery_counting_down(time_left: float)

@export var stat_node:Stat

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
@export var autorecover_amount := __DEFAULT_AUTORECOVER_AMOUNT

## The rate of autorecovery, in seconds.
@export var autorecover_rate := __DEFAULT_AUTORECOVER_RATE

## A delay before any autorecovery, in seconds.
@export var autorecover_delay := __DEFAULT_AUTORECOVER_DELAY

# A timer to determine when autorecovery can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when autorecovery occurs.
@onready var __recovery_timer := %RecoveryTimer

func _ready() -> void:
	assert(stat_node, "No stat_node:Stat component specified in %s. Select " +
		"one, or reparent this component as a child of a Stat component." 
		% [get_path()])
	
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
		autorecovery_counting_down.emit(__delay_timer.time_left)

