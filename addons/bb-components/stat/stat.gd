@icon("./stat.svg")
class_name BBStat
extends Node

## Keep track of an arbitrary numerical statistic (stat).
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/stat.md

# The lowest the stat can be.
const __LOWEST_LIMIT_STAT := 0.0

## Emitted when the stat changes.
signal changed(new_value : float)

## Emitted when the stat is recovered.  Passes in the actual amount of
## recovery up to [member max_stat].
signal recovered(amount : float)

## Emitted when fully recovered.
signal recovered_fully()

## Emitted when the stat is expended.  Passes in the actual amount of
## expenditure.
signal expended(amount : float)

## Emitted when the stat reaches 0.
signal exhausted()

## Emitted when the stat is expended, and the amount expended was available.
signal succeeded()

## Emitted when the stat is expended, and the amount expended was not available.
## Passes in the deficit difference between the amount of stat expended, and the
## stat available.
signal failed(deficit : float)

## The maximum allowed stat.
@export var max_stat := 100.0

# The current stat.
@onready var stat := max_stat:
	set(v):
		stat = clamp(v, __LOWEST_LIMIT_STAT, max_stat)

## Recover an amount of the stat.
func recover(amount : float) -> void:
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

## Set the maximum stat.
func set_max_stat(value : float) -> void:
	max_stat = value

## Get the maximum stat.
func get_max_stat() -> float:
	return max_stat

## Set the stat.
func set_stat(value : float) -> void:
	stat = value

## Get the stat.
func get_stat() -> float:
	return stat

## Return whether the stat has been exhausted.
func is_exhausted() -> bool:
	return stat <= __LOWEST_LIMIT_STAT
	
## Return whether the stat is maxed out.
func is_maxed() -> bool:
	return stat >= max_stat
