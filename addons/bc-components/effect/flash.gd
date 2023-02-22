@icon("./flash.svg")
class_name BCFlashComponent
extends Node

## Add a flash effect to a [Node2D].
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/flash.md

## Emitted when the flash occurs.
signal flashed()

## The node to flash.
@export var target_node : Node2D

## The duration of the flash (in seconds).
@export var flash_duration := 0.2

## The node's default color modulation.
@export var default_modulation := Color.WHITE

## The node's flash color modulation.
@export var flash_modulation := Color.RED

## The saturation multiplier for the flash color.
@export var saturation := 1.0

func _ready() -> void:
	if target_node == null:
		target_node = get_parent() as Node2D
	assert(target_node, ("No target_node:Node2D node specified in %s. Select " +
		"one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])

## Activate the flash effect.
func flash():
	flashed.emit()
	target_node.modulate = flash_modulation * saturation
	var tween := get_tree().create_tween()
	tween.tween_property(target_node, "modulate", default_modulation, 
		flash_duration)
