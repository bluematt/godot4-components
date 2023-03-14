@icon("./icon.svg")
extends Node
class_name BaseComponent

## A base for components.

## Emitted when the component is enabled when it was disabled.
signal was_enabled()
## Emitted when the component is disabled when it was enabled.
signal was_disabled()

@export_category("BaseComponent")

## Whether the component is enabled.
@export var enabled := true:
	set(enabled_):
		var previous_state := enabled
		enabled = enabled_

		# State change signals.
		if previous_state != enabled:
			if enabled:
				was_enabled.emit()
			else:
				was_disabled.emit()
	get:
		return enabled

## Enable the component.
func enable() -> void:
	enabled = true

## Disable the component.	
func disable() -> void:
	enabled = false

## Return whether the component is enabled.
func is_enabled() -> bool:
	return enabled

func _ready() -> void:
	pass

# Returns a nice smoothed value independent of frame rate.
func _smoothed(value: float, delta: float) -> float:
	return 1.0 - exp(-delta * value)
