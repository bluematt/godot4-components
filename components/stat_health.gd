class_name StatHealth
extends Node

## A node for managing a health-like stat.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/StatHealth.md

# The default maximum health.
const __DEFAULT_MAX_HEALTH := 100.0

# The lowest health can be.
const __LOWEST_LIMIT_HEALTH := 0.0

## Emitted when health changes.
signal changed(value: float)

## Emitted when healing takes place.  Passes in the actual amount of healing up
## to [member max_health].
signal healed(amount: float)

## Emitted when healing takes place.  Passes in the raw amount of healing.
signal healed_raw(amount: float)

## Emitted when fully healed.
signal healed_fully()

## Emitted when damage takes place.  Passes in the actual amount of damage.
signal damaged(amount:float)

## Emitted when damage takes place.  Passes in the raw amount of damage.
signal damaged_raw(amount:float)

## Emitted when health reaches 0.
signal died()

## Emitted when aliveness has been restored.
signal revived()

## The maximum allowed health.
@export var max_health := __DEFAULT_MAX_HEALTH

## The current health.
@onready var health := max_health:
	set(v):
		health = minf(v, max_health)

## Apply an amount of healing.  If [i]will_revive[/i] is true, the health can be
## from a "dead" state.
func heal(amount: float, will_revive: bool = false) -> void:
	if is_dead() and not will_revive: return

	var old_heath := health

	health += amount
	if health >= max_health:
		health = max_health

	healed_raw.emit(amount)
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
	if health <= __LOWEST_LIMIT_HEALTH:
		health = __LOWEST_LIMIT_HEALTH

	damaged_raw.emit(amount)
	damaged.emit(health - old_heath)
	changed.emit(health)
		
	if is_dead():
		died.emit()

## Return whether the health should be considered "dead".
func is_dead() -> bool:
	return not is_alive()
	
## Return whether the health should be considered "alive".
func is_alive() -> bool:
	return health > __LOWEST_LIMIT_HEALTH
	
## Return whether the health is maxed out.
func is_maxed() -> bool:
	return health >= max_health

## Revive the health from "dead" state.
func revive(amount: float) -> void:
	heal(amount, true)
	revived.emit()
