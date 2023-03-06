extends "res://addons/bb-components/base_component.gd"

## A base for animated components.

@export_category("AnimatedComponent")

## The smoothing to be applied to the animation.
@export_range(0.0, 1.0) var smoothing := 1.0:
	set=set_smoothing,
	get=get_smoothing

## Set [member smoothing].
func set_smoothing(_smoothing : float) -> void:
	smoothing = clampf(_smoothing, 0.0, 1.0)

## Get [member smoothing].
func get_smoothing() -> float:
	return smoothing
