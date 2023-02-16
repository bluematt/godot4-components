class_name StatHealth
extends Node

## A specialised node for managing a health-like stat.
##
## Health can also be set to auto heal over time after damage, after a short
## delay. [br][br]
##
## [b]How to use[/b] [br][br]
##
## 1. Attach a node instance of [class StatHealth].
## 2. Set [member max_health].  Set [member autoheal_amount],
## [member autoheal_rate], [member autoheal_delay] to enable autohealing.
## 3. Use [member heal], [member heal_fully], and [member damage] methods to
## manipulate the health stat, and the various signals to notify listeners when
## the health stat has changed. [br][br]
##
## Use the various state methods to determine the current health, and the
## signals to respond to health changing events.

## Emitted when health changes.
signal changed(value: float)

## Emitted when healing takes place.  Passes in the actual amount of healing up
## to [member max_health].
signal healed(amount: float)
## Emitted when healing takes place.  Passes in the raw amount of healing.
signal healed_raw(amount: float)
## Emitted when healing takes place.  Passes in the percentage healing of 
## [member max_health].
signal healed_percentage(percentage: float)
## Emitted when fully healed.
signal healed_fully()

## Emitted when autohealing starts.
signal autohealing_started()
## Emitted when autohealing stops.
signal autohealing_stopped()
## Emitted when autohealing is enabled or disabled.
signal autohealing_enabled(status: bool)
## Emitted when autohealing is about to begin.
signal autohealing_counting_down(time_left: float)

## Emitted when damage takes place.  Passes in the actual amount of damage.
signal damaged(amount:float)
## Emitted when damage takes place.  Passes in the raw amount of damage.
signal damaged_raw(amount:float)
## Emitted when damage takes place.  Passes in the percentage of damage.
signal damaged_percentage(percentage: float)
## Emitted when health reaches 0.
signal died()
## Emitted when aliveness has been restored.
signal revived()

@export_category("StatHealth")

## The maximum allowed health.
@export var max_health := 100.0

@export_group("Self-healing")

## Whether autohealing is enabled.  Initiate autohealing if enabled.
@export var autoheal_enabled := false:
	set(is_enabled):
		autoheal_enabled = is_enabled
		autohealing_enabled.emit(autoheal_enabled)

		if autoheal_enabled:
			call_deferred("__initiate_autohealing")
		else:
			call_deferred("__prevent_autohealing")
			call_deferred("__stop_autohealing")

## The amount of autohealing per `heal_rate` tick.
@export var autoheal_amount := 0.0

## The rate of autohealing, in seconds.
@export var autoheal_rate := 0.0

## A delay before any autohealing.
@export var autoheal_delay := 0.0

## The current health.
@onready var health := max_health:
	set(v):
		health = minf(v, max_health)

# A timer to determine when auto-healing can start.
@onready var __autoheal_delay_timer := Timer.new()

# A timer to determine when auto-healing occurs.
@onready var __autoheal_timer := Timer.new()

func _ready() -> void:
	add_child(__autoheal_delay_timer)
	add_child(__autoheal_timer)
	
	# Heal start timer should only run once per activation.
	__autoheal_delay_timer.set_one_shot(true)

	# Start the heal timer if the heal start timer times out.
	__autoheal_delay_timer.timeout.connect(func():
		if autoheal_enabled and autoheal_rate > 0.0:
			__start_autohealing())

	# Heal when the heal timer times out.
	__autoheal_timer.timeout.connect(func():
		if autoheal_enabled:
			heal(autoheal_amount))

	# Stop auto-healing when damage occurs, and start the auto-healing timer.
	damaged.connect(func(_amount:float):
		__stop_autohealing()
		__initiate_autohealing())

	# Stop auto-healing when death occurs, and prevent further auto-healing.
	died.connect(func():
		__stop_autohealing()
		__prevent_autohealing())

	# Stop auto-healing when health is fully restored.
	healed_fully.connect(func():
		__stop_autohealing()
		__prevent_autohealing())
		
	revived.connect(func():
		__initiate_autohealing())

## Apply an amount of healing.
func heal(amount: float, will_revive: bool = false) -> void:
	if is_dead() and not will_revive: return

	var old_heath := health

	health += amount
	if health >= max_health:
		health = max_health

	healed_raw.emit(amount)
	healed_percentage.emit((amount / max_health) * 100)
	healed.emit(health - old_heath)
	changed.emit(health)

	if is_maxed():
		healed_fully.emit()

## Apply a full amount of healing.
func heal_fully() -> void:
	heal(max_health)

## Apply an amount of damage.
func damage(amount: float) -> void:
	var old_heath := health

	health -= amount
	if health <= 0:
		health = 0.0

	damaged_raw.emit(amount)
	damaged_percentage.emit((amount / max_health) * 100)
	damaged.emit(health - old_heath)
	changed.emit(health)
		
	if is_dead():
		__die()

# Initiate the autohealing process timer.
func __initiate_autohealing() -> void:
	if not autoheal_enabled: return
	if is_dead() or is_maxed(): return
	
	__autoheal_delay_timer.start(autoheal_delay)
	
# Prevent the autohealing process.
func __prevent_autohealing() -> void:
	__autoheal_delay_timer.stop()

# Start autohealing.
func __start_autohealing() -> void:
	if not autoheal_enabled: return
	if is_dead(): return

	__autoheal_timer.start(autoheal_rate)
	autohealing_started.emit()

# Stop autohealing.
func __stop_autohealing() -> void:
	__autoheal_timer.stop()
	autohealing_stopped.emit()

func __die() -> void:
	autoheal_enabled = false
	died.emit()
	
func is_dead() -> bool:
	return not is_alive()
	
func is_alive() -> bool:
	return health > 0.0
	
func is_maxed() -> bool:
	return health >= max_health

func revive(amount: float) -> void:
	heal(amount, true)
	revived.emit()

func _process(_delta: float) -> void:
	if not __autoheal_delay_timer.is_stopped():
		autohealing_counting_down.emit(__autoheal_delay_timer.time_left)
