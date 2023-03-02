@icon("./flash.svg")
class_name BBFlash
extends Node

## Add a flash effect to a [Node2D].
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/flash.md

## Emitted when the flash occurs.
signal flashed()

## The node to flash.
@export var target_node : Node2D

## The duration of the flash (in seconds).
@export var duration := 0.2:
	set(d):
		duration = max(0, d)

## The node's default color modulation.
@export var default_modulation := Color.WHITE

## The node's flash color modulation.
@export var flash_modulation := Color.RED

## The saturation multiplier for the flash color.
@export var saturation := 1.0

func _ready() -> void:
	if null == target_node:
		target_node = get_parent() as Node2D
	assert(target_node, ("No target_node:Node2D node specified in %s. Select " +
		"one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])

## Activate the flash effect.
func flash():
	flashed.emit()
	target_node.modulate = flash_modulation * saturation
	var tween := get_tree().create_tween()
	tween.tween_property(target_node, "modulate", default_modulation, duration)

## Set the target node.
func set_target(new_target : Node2D) -> void:
	target_node = new_target

## Get the target node.
func get_target() -> Node2D:
	return target_node

## Set the duration of the animation.
func set_duration(time : float) -> void:
	duration = time

## Get the duration of the animation.
func get_duration() -> float:
	return duration

## Set the default modulation colour.
func set_default_modulation(new_modulation : Color) -> void:
	default_modulation = new_modulation

## Get the default modulation colour.
func get_default_modulation() -> Color:
	return default_modulation

## Set the flash modulation colour.
func set_flash_modulation(new_modulation : Color) -> void:
	flash_modulation = new_modulation

## Get the flash modulation colour.
func get_flash_modulation() -> Color:
	return flash_modulation

## Set the saturation.
func set_saturation(new_saturation : float) -> void:
	saturation = new_saturation

## Get the saturation.
func get_saturation() -> float:
	return saturation
