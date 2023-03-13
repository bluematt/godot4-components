@icon("./flash_component.svg")
class_name FlashComponent
extends Node

## Add a triggerable flash effect to a [Node2D].

## Emitted when a flash occurs.
signal flashed()

## The duration of the flash (in seconds).
@export var duration := 0.2:
	set(duration_):
		duration = max(0, duration_)
	get:
		return duration

## The node's flash color modulation.
@export var modulation := Color.RED:
	set(modulation_):
		modulation = modulation_
	get:
		return modulation

## The saturation multiplier for the flash color.
@export var saturation := 1.0:
	set(saturation_):
		saturation = saturation_
	get:
		return saturation

## The [Node2D] to flash.
var _target_node : Node2D
	
# The tween that manages the flash.
var _tween : Tween
	
# The node's original colour modulation.
var _original_modulation := Color.WHITE

func _ready() -> void:
	_target_node = get_parent() as Node2D
	assert(_target_node, "FlashComponent must be a child of a Node2D node in %s." % [str(get_path())])

	# Record the target node's original modulation so that we can tween back to it.
	_original_modulation = _target_node.modulate

## Activate the flash effect.
func flash():
	# Remove any existing tweens.
	if _tween and _tween.is_running(): _tween.kill()

	# Reset the node's modulation to the start colour.
	_target_node.modulate = modulation * saturation

	# Create a new flash effect.
	_tween = get_tree().create_tween()
	_tween.tween_property(_target_node, "modulate", _original_modulation, duration)
	_tween.play()

	# Emit the signal that the flash has occured.
	flashed.emit()
