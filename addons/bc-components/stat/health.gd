@icon("./health.svg")
class_name BBHealth
extends Node

## Keep track of a health-like numerical statistic (stat).
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/health.md

# The lowest health can be.
const __LOWEST_LIMIT_HEALTH := 0.0

## Emitted when health changes.
signal changed(value: float)

## Emitted when healing takes place.  Passes in the actual amount of healing up
## to [member max_health].
signal healed(amount: float)

## Emitted when fully healed.
signal healed_fully()

## Emitted when damage takes place.  Passes in the actual amount of damage.
signal damaged(amount:float)

## Emitted when health reaches 0.
signal died()

## Emitted when health has been restored after death.
signal revived()

## The maximum allowed health.
@export var max_health := 100.0

## The current health.
@onready var __health := max_health:
	set(v):
		__health = clamp(v, __LOWEST_LIMIT_HEALTH, max_health)

## Apply an amount of healing.  If [i]will_revive[/i] is true, the health can be
## from a "dead" state.
func heal(amount : float, will_revive : bool = false) -> void:
	if is_dead() and not will_revive: return

	var old_heath := __health

	__health += amount
	if __health >= max_health:
		__health = max_health

	healed.emit(__health - old_heath)
	changed.emit(__health)

	if is_maxed():
		healed_fully.emit()

## Apply a full amount of healing.
func heal_fully() -> void:
	heal(max_health)

## Apply an amount of damage.
func damage(amount : float) -> void:
	var old_heath := __health

	__health -= amount
	if __health <= __LOWEST_LIMIT_HEALTH:
		__health = __LOWEST_LIMIT_HEALTH

	damaged.emit(old_heath - __health)
	changed.emit(__health)
		
	if is_dead():
		died.emit()

## Return whether the health should be considered "dead".
func is_dead() -> bool:
	return not is_alive()
	
## Return whether the health should be considered "alive".
func is_alive() -> bool:
	return __health > __LOWEST_LIMIT_HEALTH
	
## Return whether the health is maxed out.
func is_maxed() -> bool:
	return __health >= max_health

## Revive the health from "dead" state.
func revive(amount: float) -> void:
	if is_dead():
		heal(amount, true)
		revived.emit()

## Return the current health.
func get_health() -> float:
	return __health

## Set the health.
func set_health(value : float) -> void:
	__health = value

## Return the maximum health.
func get_max_health() -> float:
	return max_health

## Set the maximum health.
func set_max_health(value : float) -> void:
	max_health = value
