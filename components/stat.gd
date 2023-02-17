class_name Stat
extends Node

## A generic stat component.
##
## [b]How to use[/b] [br][br]
##
## 1. Attach a node instance of [Stat]. [br]
## 2. Set [member max_stat]. [br]
## 3. Use [member recover], [member recover_fully], [member expend] and
## [member exhaust] methods to manipulate the stat. [br][br]
##
## Use the various state methods to determine the current stat, and the
## signals to respond to stat changing events. [br][br]
##
## If you wish to replicate a health-type stat, the [StatHealth] component may
## be more suitable.

## Emitted when the stat changes.
signal changed(value: float)

## Emitted when the stat is recovered.  Passes in the actual amount of
## recovery up to [member max_stat].
signal recovered(amount: float)
## Emitted when the stat is recovered.  Passes in the raw amount of
## recovery.
signal recovered_raw(amount: float)
## Emitted when the stat is recovered.  Passes in the percentage of recovery
## of [member max_stat].
signal recovered_percentage(percentage: float)
## Emitted when fully recovered.
signal recovered_fully()

## Emitted when the stat is expended.  Passes in the actual amount of
## expenditure.
signal expended(amount: float)
## Emitted when the stat is expended.  Passes in the raw amount of expenditure.
signal expended_raw(amount: float)
## Emitted when the stat is expended.  Passes in the percentage of expenditure.
signal expended_percentage(percentage: float)
## Emitted when the stat reaches 0.
signal exhausted()

## Emitted when the stat is expended, and the amount expended was available.
signal succeeded()
## Emitted when the stat is expended, and the amount expended was not available.
## Passes in the deficit difference between the amount of stat expended, and the
## stat available.
signal failed(deficit: float)

@export_category("Stat")

## The maximum allowed stat.
@export var max_stat := 100.0

## The current stat.
@onready var stat := max_stat:
	set(v):
		stat = minf(v, max_stat)

## Recover an amount of the stat.
func recover(amount: float) -> void:
	var old_stat := stat

	stat += amount
	if stat >= max_stat:
		stat = max_stat

	recovered_raw.emit(amount)
	recovered_percentage.emit((amount / max_stat) * 100)
	recovered.emit(stat - old_stat)
	changed.emit(stat)

	if is_maxed():
		recovered_fully.emit()

## Recover the stat to full.
func recover_fully() -> void:
	recover(max_stat)

## Expend an amount of the stat.  Returns whether there was enough of the stat
## to consider the expenditure "successful".
func expend(amount: float) -> bool:
	var old_stat := stat

	stat -= amount
	if stat <= 0:
		stat = 0.0

	expended_raw.emit(amount)
	expended_percentage.emit((amount / max_stat) * 100)
	expended.emit(stat - old_stat)
	changed.emit(stat)
		
	if is_exhausted():
		exhausted.emit()
	
	# Determine whether there was enough of the stat to succeed.
	var success := old_stat >= amount
	if success:
		succeeded.emit()
	else:
		failed.emit(old_stat - amount)
	
	return success

## Return whether the stat has been exhausted.
func is_exhausted() -> bool:
	return stat <= 0.0
	
## Return whether the stat is maxed out.
func is_maxed() -> bool:
	return stat >= max_stat
