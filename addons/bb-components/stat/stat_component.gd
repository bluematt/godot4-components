@icon("./stat_component.svg")
extends Node
class_name StatComponent

## Keep track of an arbitrary numerical statistic.

## The lowest the stat can be.
const LOWEST_LIMIT_STAT := 0.0

## Emitted when the stat changes.
signal changed(stat: float)

## Emitted when the stat is recovered.  Passes in the actual amount of
## recovery up to [member max_stat].
signal recovered(amount: float)

## Emitted when fully recovered.
signal recovered_fully()

## Emitted when the stat is expended.  Passes in the actual amount of
## expenditure.
signal expended(amount: float)

## Emitted when the stat reaches 0.
signal exhausted()

## Emitted when the stat is expended, and the amount expended was available.
signal succeeded()

## Emitted when the stat is expended, and the amount expended was not available.
## Passes in the deficit difference between the amount of stat expended, and the
## stat available.
signal failed(deficit: float)

## The maximum allowed stat.
@export_range(0.0, 1000.0, 0.01, "or_greater", "hide_slider") var max_stat := 100.0

# The current stat.
@onready var stat := max_stat:
	set(stat_):
		stat = clampf(stat_, LOWEST_LIMIT_STAT, max_stat)

## Recover an amount of the stat.
func recover(amount: float) -> void:
	var old_stat := stat

	stat += amount

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
	return stat <= LOWEST_LIMIT_STAT
	
## Return whether the stat is maxed out.
func is_maxed() -> bool:
	return stat >= max_stat
