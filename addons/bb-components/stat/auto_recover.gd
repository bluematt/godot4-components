@icon("./auto_recover.svg")
class_name BBAutoRecover
extends "res://addons/bb-components/base_component.gd"

## Give autorecovery capability to a [BBHealth].

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
@export var stat_node:BBStat:
	set=set_stat_node, get=get_stat_node

## Set [member stat_node].
func set_stat_node(_node : BBStat) -> void: stat_node = _node
	
## Get [member stat_node].
func get_stat_node() -> BBStat: return stat_node

@export_group("Autorecovery", "autorecover_")

## The amount of autorecovery per autorecover_rate` tick.
@export var autorecover_amount := 0.0:
	set=set_autorecover_amount, get=get_autorecover_amount

## Set [member autorecover_amount].
func set_autorecover_amount(_autorecover_amount : float) -> void:
	autorecover_amount = _autorecover_amount

## Get [member autorecover_amount].
func get_autorecover_amount() -> float: return autorecover_amount

## The rate of autorecovery (in seconds).
@export var autorecover_rate := 0.0:
	set=set_autorecover_rate, get=get_autorecover_rate

## Set [member autorecover_rate].
func set_autorecover_rate(_autorecover_rate : float) -> void:
	autorecover_rate = _autorecover_rate

## Get [member autorecover_rate].
func get_autorecover_rate() -> float: return autorecover_rate

## The delay before autorecovery starts (in seconds).
@export var autorecover_delay := 0.0:
	set=set_autorecover_delay, get=get_autorecover_delay

## Set [member autorecover_delay].
func set_autorecover_delay(_autorecover_delay : float) -> void:
	autorecover_delay = _autorecover_delay

## Get [member autorecover_delay].
func get_autorecover_delay() -> float: return autorecover_delay

# A timer to determine when autorecovery can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when autorecovery occurs.
@onready var __recovery_timer := %RecoveryTimer

func _ready() -> void:
	assert(stat_node, ("No stat_node:Stat component specified in %s. Select " +
		"one, or reparent this component as a child of a Stat component.") 
		% [str(get_path())])
		
	# Lambda for DRY signal callbacks...
	var disable_autorecovery := func():
		__stop_autorecovery()
		__prevent_autorecovery()
	
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
		disable_autorecovery.call())
		
	# Stop autorecovery when the stat is fully restored.
	stat_node.recovered_fully.connect(func():
		disable_autorecovery.call())
		
	# Start autorecovery when the component is enabled.
	was_enabled.connect(func():
		__initiate_autorecovery())
		
	# Stop autorecovery when the component is disabled.
	was_disabled.connect(func():
		disable_autorecovery.call())

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

## Return the amount of time left before autorecovery commences (in seconds).
func get_delay_time_remaining() -> float:
	if not __delay_timer.is_stopped():
		return __delay_timer.time_left

	return 0.0
