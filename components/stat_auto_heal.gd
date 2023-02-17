class_name StatAutoHeal
extends Node

## A node to automatically heal a [StatHealth] node.
##
## [b]How to use[/b] [br][br]
##
## 1. Attach a node instance of [StatAutoHeal].  A good place is as a 
## child of the [StatHealth] you want to autoheal. [br]
## 2. Select the [StatHealth] node to manipulate in [member health_stat_node].
## [br]
## 3. Set the various autoheal properties to your liking. [br]
## 4. Enable the component to allow autohealing.

## Emitted when autohealing starts.
signal autohealing_started()
## Emitted when autohealing stops.
signal autohealing_stopped()
## Emitted when autohealing is enabled or disabled.
signal autohealing_enabled(status: bool)
## Emitted when autohealing is about to begin.
signal autohealing_counting_down(time_left: float)

@export_category("StatAutoHeal")

@export_node_path("StatHealth") var health_stat_node

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
@export var autoheal_amount := 0.0

## The rate of autohealing, in seconds.
@export var autoheal_rate := 0.0

## A delay before any autohealing, in seconds.
@export var autoheal_delay := 0.0

# A timer to determine when autohealing can start.
@onready var __delay_timer := %DelayTimer

# A timer to determine when autohealing occurs.
@onready var __heal_timer := %HealTimer

# The [StatHealth] node to operate on.
@onready var __health:StatHealth = get_node(health_stat_node)

func _ready() -> void:
	assert(health_stat_node)
	assert(__health)
	
	# Start the heal timer if the heal start timer times out.
	__delay_timer.timeout.connect(func():
		if enabled and autoheal_rate > 0.0:
			__start_autohealing())

	# Heal when the heal timer times out.
	__heal_timer.timeout.connect(func():
		if enabled:
			__health.heal(autoheal_amount))
	
	# Stop autohealing on damage, and start the autohealing timer.
	__health.damaged.connect(func(_amount:float):
		__stop_autohealing()
		__initiate_autohealing())

	# Stop autohealing on death, and prevent further autohealing.
	__health.died.connect(func():
		__stop_autohealing()
		__prevent_autohealing())

	# Stop autohealing when health is fully restored.
	__health.healed_fully.connect(func():
		__stop_autohealing()
		__prevent_autohealing())
		
	# Allow autohealing to resume if revived.
	__health.revived.connect(func():
		__initiate_autohealing())

# Initiate the autohealing process timer.
func __initiate_autohealing() -> void:
	if not enabled: return
	if __health.is_dead() or __health.is_maxed(): return
	
	__delay_timer.start(autoheal_delay)
	
# Prevent the autohealing process.
func __prevent_autohealing() -> void:
	__delay_timer.stop()

# Start autohealing.
func __start_autohealing() -> void:
	if not enabled: return
	if __health.is_dead(): return

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
