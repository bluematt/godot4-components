@icon("./auto_heal.svg")
class_name BBAutoHeal
extends Node

## Give a [HealthComponent] the ability to autoheal over time.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/auto_heal.md

# The autoheal rate which triggers autohealing.
const __TRIGGER_LIMIT_AUTOHEAL_RATE := 0.0

## Emitted when autohealing starts.
signal autoheal_started()

## Emitted when autohealing stops.
signal autoheal_stopped()

## Emitted when autohealing is enabled or disabled.
signal autoheal_enabled(status: bool)

## Emitted when autohealing is about to begin.
signal autoheal_counting_down(time_left: float)

@export var health_stat_node:BBHealth

## Whether autohealing is enabled.  Initiate autohealing if enabled.
@export var enabled := false:
	set(is_enabled):
		enabled = is_enabled
		autoheal_enabled.emit(enabled)

		if enabled:
			call_deferred("__initiate_autoheal")
		else:
			call_deferred("__prevent_autoheal")
			call_deferred("__stop_autoheal")

@export_group("Autoheal", "autoheal_")

## The amount of autohealing per `autoheal_rate` tick.
@export var autoheal_amount := 0.0

## The rate of autohealing, in seconds.
@export var autoheal_rate := 0.0

## A delay before any autohealing, in seconds.
@export var autoheal_delay := 0.0

# A timer to determine when autohealing can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when autohealing occurs.
@onready var __heal_timer := %HealTimer

func _ready() -> void:
	if health_stat_node == null:
		health_stat_node = get_parent() as BBHealth
	assert(health_stat_node, ("No health_stat_node:BBHealth component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBHealth component.") % [str(get_path())])
	
	# Start the heal timer if the heal start timer times out.
	__delay_timer.timeout.connect(func():
		if enabled and autoheal_rate > __TRIGGER_LIMIT_AUTOHEAL_RATE:
			__start_autoheal())

	# Heal when the heal timer times out.
	__heal_timer.timeout.connect(func():
		if enabled:
			health_stat_node.heal(autoheal_amount))
	
	# Stop autohealing on damage, and start the autohealing timer.
	health_stat_node.damaged.connect(func(_amount:float):
		__stop_autoheal()
		__initiate_autoheal())

	# Stop autohealing on death, and prevent further autohealing.
	health_stat_node.died.connect(func():
		__stop_autoheal()
		__prevent_autoheal())

	# Stop autohealing when health is fully restored.
	health_stat_node.healed_fully.connect(func():
		__stop_autoheal()
		__prevent_autoheal())
		
	# Allow autohealing to resume if revived.
	health_stat_node.revived.connect(func():
		__initiate_autoheal())

# Initiate the autohealing process timer.
func __initiate_autoheal() -> void:
	if not enabled: return
	if health_stat_node.is_dead() or health_stat_node.is_maxed(): return
	
	__delay_timer.start(autoheal_delay)
	
# Prevent the autohealing process.
func __prevent_autoheal() -> void:
	__delay_timer.stop()

# Start autohealing.
func __start_autoheal() -> void:
	if not enabled: return
	if health_stat_node.is_dead(): return

	__heal_timer.start(autoheal_rate)
	autoheal_started.emit()

# Stop autohealing.
func __stop_autoheal() -> void:
	__heal_timer.stop()
	autoheal_stopped.emit()

# Update the amount of time remaining on the autoheal delay timer.
func _process(_delta: float) -> void:
	if not __delay_timer.is_stopped():
		autoheal_counting_down.emit(get_delay_time_remaining())

## Enable autoheal.
func enable() -> void:
	enabled = true

## Disable autoheal.
func disable() -> void:
	enabled = false

## Return the amount of time left before autohealing commences (in seconds).
func get_delay_time_remaining() -> float:
	if not __delay_timer.is_stopped():
		return __delay_timer.time_left

	return 0.0