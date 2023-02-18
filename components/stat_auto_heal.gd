class_name StatAutoHeal
extends Node

## A node to automatically heal a [StatHealth] node.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/StatAutoHeal.md

# The default autoheal amount.
const __DEFAULT_AUTOHEAL_AMOUNT := 0.0

# The default autoheal rate.
const __DEFAULT_AUTOHEAL_RATE := 0.0

# The default autoheal delay.
const __DEFAULT_AUTOHEAL_DELAY := 0.0

# The autoheal rate which triggers autohealing.
const __TRIGGER_LIMIT_AUTOHEAL_RATE := 0.0

## Emitted when autohealing starts.
signal autohealing_started()

## Emitted when autohealing stops.
signal autohealing_stopped()

## Emitted when autohealing is enabled or disabled.
signal autohealing_enabled(status: bool)

## Emitted when autohealing is about to begin.
signal autohealing_counting_down(time_left: float)

@export var health_stat_node:StatHealth

## Whether autohealing is enabled.  Initiate autohealing if enabled.
@export var enabled := false:
	set(is_enabled):
		enabled = is_enabled
		autohealing_enabled.emit(enabled)

		if enabled:
			call_deferred("__initiate_autohealing")
		else:
			call_deferred("__prevent_autohealing")
			call_deferred("__stop_autohealing")

@export_group("Autohealing", "autoheal_")

## The amount of autohealing per `autoheal_rate` tick.
@export var autoheal_amount := __DEFAULT_AUTOHEAL_AMOUNT

## The rate of autohealing, in seconds.
@export var autoheal_rate := __DEFAULT_AUTOHEAL_RATE

## A delay before any autohealing, in seconds.
@export var autoheal_delay := __DEFAULT_AUTOHEAL_DELAY

# A timer to determine when autohealing can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when autohealing occurs.
@onready var __heal_timer := %HealTimer

func _ready() -> void:
	if health_stat_node == null:
		health_stat_node = get_parent() as StatHealth
	assert(health_stat_node)
	
	# Start the heal timer if the heal start timer times out.
	__delay_timer.timeout.connect(func():
		if enabled and autoheal_rate > __TRIGGER_LIMIT_AUTOHEAL_RATE:
			__start_autohealing())

	# Heal when the heal timer times out.
	__heal_timer.timeout.connect(func():
		if enabled:
			health_stat_node.heal(autoheal_amount))
	
	# Stop autohealing on damage, and start the autohealing timer.
	health_stat_node.damaged.connect(func(_amount:float):
		__stop_autohealing()
		__initiate_autohealing())

	# Stop autohealing on death, and prevent further autohealing.
	health_stat_node.died.connect(func():
		__stop_autohealing()
		__prevent_autohealing())

	# Stop autohealing when health is fully restored.
	health_stat_node.healed_fully.connect(func():
		__stop_autohealing()
		__prevent_autohealing())
		
	# Allow autohealing to resume if revived.
	health_stat_node.revived.connect(func():
		__initiate_autohealing())

# Initiate the autohealing process timer.
func __initiate_autohealing() -> void:
	if not enabled: return
	if health_stat_node.is_dead() or health_stat_node.is_maxed(): return
	
	__delay_timer.start(autoheal_delay)
	
# Prevent the autohealing process.
func __prevent_autohealing() -> void:
	__delay_timer.stop()

# Start autohealing.
func __start_autohealing() -> void:
	if not enabled: return
	if health_stat_node.is_dead(): return

	__heal_timer.start(autoheal_rate)
	autohealing_started.emit()

# Stop autohealing.
func __stop_autohealing() -> void:
	__heal_timer.stop()
	autohealing_stopped.emit()

# Update the amount of time remaining on the autoheal delay timer.
func _process(_delta: float) -> void:
	if not __delay_timer.is_stopped():
		autohealing_counting_down.emit(__delay_timer.time_left)
