@icon("./auto_heal_component.svg")
class_name AutoHealComponent
extends BaseComponent

## Give autoheal capability to a [HealthComponent].

## Emitted when autohealing is initiated.
signal autoheal_initiated()

## Emitted when autohealing starts.
signal autoheal_started()

## Emitted when autohealing stops.
signal autoheal_stopped()

## Emitted when autohealing is enabled or disabled.
signal autoheal_enabled(status: bool)

@export_group("Autoheal", "autoheal_")

## The amount of autohealing per `autoheal_rate` tick.
@export_range(0.0, 1000.0, 0.01, "or_greater", "hide_slider") var autoheal_amount := 1.0:
	set(autoheal_amount_):
		autoheal_amount = max(0.0, autoheal_amount_)
	
## The rate of autohealing, in seconds.
@export_range(0.0, 60.0, 0.01, "or_greater", "suffix:/s", "hide_slider") var autoheal_rate := 1.0:
	set(autoheal_rate_):
		autoheal_rate = max(0.0, autoheal_rate_)
		
## A delay before any autohealing, in seconds.
@export_range(0.0, 60.0, 0.01, "or_greater", "suffix:s", "hide_slider") var autoheal_delay := 1.0:
	set(autoheal_delay_):
		autoheal_delay = max(0.0, autoheal_delay_)

var _health_component: HealthComponent
var _heal_timer: Timer
var _delay_timer: Timer

func _ready() -> void:
	_health_component = get_parent() as HealthComponent
	assert(_health_component, "AutoHealComponent must be a child of a HealthComponent in %s." % [str(get_path())])

	_heal_timer = Timer.new()
	_delay_timer = Timer.new()
	_delay_timer.one_shot = true
	
	_heal_timer.timeout.connect(_on_heal_timer_timeout)
	_delay_timer.timeout.connect(_on_delay_timer_timeout)

	_health_component.damaged.connect(_on_health_component_damaged)
	_health_component.died.connect(_on_health_component_died)
	_health_component.healed_fully.connect(_on_health_component_healed_fully)
	_health_component.revived.connect(_on_health_component_revived)
	
	was_enabled.connect(_on_was_enabled)
	was_disabled.connect(_on_was_disabled)

## Initiate the autohealing process.
func initiate_autoheal() -> void:
	if not enabled:
		return
	if _health_component.is_dead() or _health_component.is_maxed():
		stop_autoheal()
		return
	
	_heal_timer.stop()
	_delay_timer.start(autoheal_delay)
	autoheal_initiated.emit()
	
## Start autohealing immediately.
func start_autoheal() -> void:
	if not enabled:
		return
	if _health_component.is_maxed():
		stop_autoheal()
		return

	_delay_timer.stop()
	_heal_timer.start(autoheal_rate)
	autoheal_started.emit()

## Stop autohealing immediately.
func stop_autoheal() -> void:
	_heal_timer.stop()
	_delay_timer.stop()
	autoheal_stopped.emit()

# Heal when the heal timer times out.
func _on_heal_timer_timeout() -> void:
	if enabled:
		_health_component.heal(autoheal_amount)
		
# Start the heal timer when the delay timer times out.
func _on_delay_timer_timeout() -> void:
	if enabled:
		start_autoheal()

# When the [member health_component] is damaged, restart autoheal.
func _on_health_component_damaged() -> void:
	initiate_autoheal()

# When the [member health_component] dies, stop autoheal.
func _on_health_component_died() -> void:
	stop_autoheal()

# When the [member health_component] is fully healed, stop autoheal.
func _on_health_component_healed_fully() -> void:
	stop_autoheal()

# When the [member health_component] is revived, initiate autoheal.
func _on_health_component_revived() -> void:
	initiate_autoheal()
	
# If the component is enabled, initiate autoheal.
func _on_was_enabled() -> void:
	initiate_autoheal()

# If the component is disabled, stop autoheal.
func _on_was_disabled() -> void:
	stop_autoheal()
