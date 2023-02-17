class_name StatAutoRecover
extends Node

## A node to automatically recover a [Stat] node.
##
## [b]How to use[/b] [br][br]
##
## 1. Attach a node instance of [StatAutoRecover].  A good place is as a 
## child of the [Stat] you want to autorecover. [br]
## 2. Select the [Stat] node to manipulate in [member stat_node].
## [br]
## 3. Set the various autorecover properties to your liking. [br]
## 4. Enable the component to allow autorecovery.

## Emitted when autorecovery starts.
signal autorecovery_started()
## Emitted when autorecovery stops.
signal autorecovery_stopped()
## Emitted when autorecovery is enabled or disabled.
signal autorecovery_enabled(status: bool)
## Emitted when autorecovery is about to begin.
signal autorecovery_counting_down(time_left: float)

@export_category("StatAutoRecover")

@export_node_path("Stat") var stat_node

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

## The rate of autorecovery, in seconds.
@export var autorecover_rate := 0.0

## A delay before any autorecovery, in seconds.
@export var autorecover_delay := 0.0

# A timer to determine when auto-healing can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when auto-healing occurs.
@onready var __recovery_timer := %RecoveryTimer

# The [Stat] node to operate on.
@onready var __stat:Stat = get_node(stat_node)

func _ready() -> void:
	assert(stat_node)
	assert(__stat)
	
	# Start the recovery timer when the delay timer times out.
	__delay_timer.timeout.connect(func():
		if enabled and autorecover_rate > 0.0:
			__start_autorecovery())

	# Recover when the recovery timer times out.
	__recovery_timer.timeout.connect(func():
		if enabled:
			__stat.recover(autorecover_amount))
			
	# Stop autorecovery on expenditure, and restart the delay timer.
	__stat.expended.connect(func(_amount:float):
		__stop_autorecovery()
		__initiate_autorecovery())
		
	# Stop autorecovery when the stat is fully restored.
	__stat.recovered_fully.connect(func():
		__stop_autorecovery()
		__prevent_autorecovery())

# Initiate the autohealing process timer.
func __initiate_autorecovery() -> void:
	if not enabled: return
	if __stat.is_maxed(): return
	
	__delay_timer.start(autorecover_delay)
	
# Prevent the autohealing process.
func __prevent_autorecovery() -> void:
	__delay_timer.stop()

# Start autohealing.
func __start_autorecovery() -> void:
	if not enabled: return
	if __stat.is_exhausted(): return

	__recovery_timer.start(autorecover_rate)
	autorecovery_started.emit()

# Stop autohealing.
func __stop_autorecovery() -> void:
	__recovery_timer.stop()
	autorecovery_stopped.emit()

# Update the amount of time remaining on the autoheal delay timer.
func _process(_delta: float) -> void:
	if not __delay_timer.is_stopped():
		autorecovery_counting_down.emit(__delay_timer.time_left)
