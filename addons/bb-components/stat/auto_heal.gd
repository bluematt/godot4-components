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

@export var health_node:BBHealth

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
	if null == health_node:
		health_node = get_parent() as BBHealth
	assert(health_node, ("No health_stat_node:BBHealth component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBHealth component.") % [str(get_path())])
	
	# Start the heal timer if the heal start timer times out.
	__delay_timer.timeout.connect(func():
		if enabled and autoheal_rate > __TRIGGER_LIMIT_AUTOHEAL_RATE:
			__start_autoheal())

	# Heal when the heal timer times out.
	__heal_timer.timeout.connect(func():
		if enabled:
			health_node.heal(autoheal_amount))
	
	# Stop autohealing on damage, and start the autohealing timer.
	health_node.damaged.connect(func(_amount:float):
		__stop_autoheal()
		__initiate_autoheal())

	# Stop autohealing on death, and prevent further autohealing.
	health_node.died.connect(func():
		__stop_autoheal()
		__prevent_autoheal())

	# Stop autohealing when health is fully restored.
	health_node.healed_fully.connect(func():
		__stop_autoheal()
		__prevent_autoheal())
		
	# Allow autohealing to resume if revived.
	health_node.revived.connect(func():
		__initiate_autoheal())

# Initiate the autohealing process timer.
func __initiate_autoheal() -> void:
	if not enabled: return
	if health_node.is_dead() or health_node.is_maxed(): return
	
	__delay_timer.start(autoheal_delay)
	
# Prevent the autohealing process.
func __prevent_autoheal() -> void:
	__delay_timer.stop()

# Start autohealing.
func __start_autoheal() -> void:
	if not enabled: return
	if health_node.is_dead(): return

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

## Set the stat node.
func set_health(new_health : BBHealth) -> void:
	health_node = new_health
	
## Get the stat node.
func get_health() -> BBHealth:
	return health_node

## Set enabled.
func set_enabled(is_enabled : bool) -> void:
	enabled = is_enabled
	
## Get enabled.
func get_enabled() -> bool:
	return enabled

## Set the autoheal amount.
func set_autoheal_amount(amount : float) -> void:
	autoheal_amount = amount

## Get the autoheal amount.
func get_autoheal_amount() -> float:
	return autoheal_amount

## Set the autoheal rate.
func set_autoheal_rate(rate : float) -> void:
	autoheal_rate = rate

## Get the autoheal rate.
func get_autoheal_rate() -> float:
	return autoheal_rate

## Set the autoheal delay.
func set_autoheal_delay(delay : float) -> void:
	autoheal_delay = delay

## Get the autoheal delay.
func get_autoheal_delay() -> float:
	return autoheal_delay

## Enable autoheal.
func enable() -> void:
	set_enabled(true)

## Disable autoheal.
func disable() -> void:
	set_enabled(false)
	
## Return whether the component is enabled.
func is_enabled() -> bool:
	return get_enabled()

## Return the amount of time left before autohealing commences (in seconds).
func get_delay_time_remaining() -> float:
	if not __delay_timer.is_stopped():
		return __delay_timer.time_left

	return 0.0
