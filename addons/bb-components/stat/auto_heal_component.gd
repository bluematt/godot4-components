@icon("./auto_heal.svg")
class_name BBAutoHeal
extends "res://addons/bb-components/base_component.gd"

## Give autoheal capability to a [BBHealth].

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

@export var health_node:BBHealth:
	set=set_health_node, get=get_health_node

## Set [member health_node].
func set_health_node(_node : BBHealth) -> void:
	health_node = _node
	
## Get [member health_node].
func get_health_node() -> BBHealth:
	return health_node

@export_group("Autoheal", "autoheal_")

## The amount of autohealing per `autoheal_rate` tick.
@export var autoheal_amount := 0.0:
	set=set_autoheal_amount, get=get_autoheal_amount
	
## Set [member autoheal_amount].
func set_autoheal_amount(_autoheal_amount : float) -> void:
	autoheal_amount = _autoheal_amount

## Get [member autoheal_amount].
func get_autoheal_amount() -> float: return autoheal_amount

## The rate of autohealing, in seconds.
@export var autoheal_rate := 0.0:
	set=set_autoheal_rate, get=get_autoheal_rate

## Set [member autoheal_rate].
func set_autoheal_rate(_autoheal_rate : float) -> void:
	autoheal_rate = _autoheal_rate

## Get [member autoheal_rate].
func get_autoheal_rate() -> float: return autoheal_rate

## A delay before any autohealing, in seconds.
@export var autoheal_delay := 0.0:
	set=set_autoheal_delay, get=get_autoheal_delay

## Set [member autoheal_delay].
func set_autoheal_delay(_autoheal_delay : float) -> void:
	autoheal_delay = _autoheal_delay

## Get [member autoheal_delay].
func get_autoheal_delay() -> float: return autoheal_delay

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
		
	# Lambda for DRY signal callbacks...
	var disable_autoheal := func():
		__stop_autoheal()
		__prevent_autoheal()
	
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
		disable_autoheal.call())

	# Stop autohealing on death, and prevent further autohealing.
	health_node.died.connect(func():
		disable_autoheal.call())

	# Stop autohealing when health is fully restored.
	health_node.healed_fully.connect(func():
		disable_autoheal.call())
		
	# Allow autohealing to resume if revived.
	health_node.revived.connect(func():
		__initiate_autoheal())
		
		# Start autorecovery when the component is enabled.
	was_enabled.connect(func():
		__initiate_autoheal())
		
	# Stop autorecovery when the component is disabled.
	was_disabled.connect(func():
		disable_autoheal.call())

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

## Return the amount of time left before autohealing commences (in seconds).
func get_delay_time_remaining() -> float:
	if not __delay_timer.is_stopped():
		return __delay_timer.time_left

	return 0.0
