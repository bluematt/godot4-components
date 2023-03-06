@icon("./icon.svg")
extends Node

## A base for components.

## Emitted when the component is enabled when it was disabled.
signal was_enabled()
## Emitted when the component is disabled when it was enabled.
signal was_disabled()

@export_category("BaseComponent")

## Whether the component is enabled.
@export var enabled := true:
	set=set_enabled,
	get=get_enabled

## Set [member enabled].
func set_enabled(_enabled : bool) -> void:
	var previous_state := enabled
	enabled = _enabled

	# State change signals.
	if previous_state != enabled:
		if enabled:
			was_enabled.emit()
		else:
			was_disabled.emit()

## Get [member enabled].
func get_enabled() -> bool:
	return enabled

## Enable the component.
func enable() -> void:
	set_enabled(true)

## Disable the component.	
func disable() -> void:
	set_enabled(false)

## Return whether the component is enabled.
func is_enabled() -> bool:
	return get_enabled()

func _ready() -> void: pass
