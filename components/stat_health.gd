class_name StatHealth
extends Node

## A node for managing a health-like stat.
##
## [b]How to use[/b] [br][br]
##
## 1. Attach a node instance of [StatHealth]. [br]
## 2. Set [member max_health]. [br]
## 3. Use [member heal], [member heal_fully], and [member damage] methods to
## manipulate the health stat. [br][br]
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
		died.emit()

## Return whether the health should be considered "dead".
func is_dead() -> bool:
	return not is_alive()
	
## Return whether the health should be considered "alive".
func is_alive() -> bool:
	return health > 0.0
	
## Return whether the health is maxed out.
func is_maxed() -> bool:
	return health >= max_health

## Revive the health from "dead" state.
func revive(amount: float) -> void:
	heal(amount, true)
	revived.emit()
