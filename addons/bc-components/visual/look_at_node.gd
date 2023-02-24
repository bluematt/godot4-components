@icon("./look_at_node.svg")
class_name VisualLookAtNode
extends Node

## Rotates a Node2D to "look" at another Node2D.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/VisualLookAtNode.md

## The node to rotate.
@export var node:Node2D

## The node to follow.
@export var target_node:Node2D = null

## The smoothing to be applied to the rotation.
@export_range(0.0, 1.0) var smoothing := 1.0

## Whether the component is enabled.
@export var enabled := true

## The interpolated target node position.
var __target_position:Vector2

func _ready() -> void:
	if not node:
		node = get_parent()
	assert(node, ("No node:Node2D component specified in %s. Select one, or " +
		"reparent this component as a child of a Node2D node.")
		% [str(get_path())])

	assert(target_node, ("No target_node:Node2D component specified in %s.") 
		% [str(get_path())])

	__target_position = target_node.global_position

func _process(_delta: float) -> void:
	if enabled:
		__target_position = lerp(__target_position, target_node.global_position, smoothing)
		node.look_at(__target_position)
