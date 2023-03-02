@icon("./look_at_node.svg")
class_name BBLookAtNode
extends Node

## Rotates a Node2D to "look" at another Node2D.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/look_at_node.md

## Emitted when the [member object_node] is looking towards the target (or 
## close to it).
signal looked_at(target : Vector2)

## Emitted when the [member object_node] is looking [i]directly[/i] at the
## target.
signal looked_directly_at(target : Vector2)

## The node to rotate.
@export var object_node:Node2D

## The node to follow.
@export var follow_node:Node2D = null

## The smoothing to be applied to the rotation.
@export_range(0.0, 1.0) var smoothing := 1.0

## Whether the component is enabled.
@export var enabled := true

## The interpolated target node position.
var __target_position:Vector2

func _ready() -> void:
	if not object_node:
		object_node = get_parent()
	assert(object_node, ("No object_node:Node2D component specified in %s. " +
		"Select one, or reparent this component as a child of a Node2D node.")
		% [str(get_path())])

	assert(follow_node, ("No follow_node:Node2D component specified in %s.") 
		% [str(get_path())])

	__target_position = follow_node.global_position

func _process(_delta: float) -> void:
	if enabled:
		# Keep track of the old target position so we can check later if we need
		# to emit signals.
		var old_target_position := __target_position

		# Look towards the target.
		__target_position = lerp(__target_position, follow_node.global_position, smoothing)
		object_node.look_at(__target_position)

		# Emit signals if required.
		if old_target_position != __target_position:
			if __target_position.is_equal_approx(follow_node.global_position):
				looked_at.emit(__target_position)
			if __target_position == follow_node.global_position:
				looked_directly_at.emit(__target_position)

## Set the node to rotate.
func set_object_node(node : Node2D) -> void:
	object_node = node

## Get the node to rotate.
func get_object_node() -> Node2D:
	return object_node

## Set the node to follow.
func set_follow_node(node : Node2D) -> void:
	follow_node = node

## Get the node to follow.
func get_follow_node() -> Node2D:
	return follow_node
	
## Set the smoothing.
func set_smoothing(new_smoothing : float) -> void:
	smoothing = new_smoothing

## Get the smoothing.
func get_smoothing() -> float:
	return smoothing

## Set enabled.
func set_enabled(is_enabled : bool) -> void:
	enabled = is_enabled

## Get enabled.
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

## Return where the node is currently looking.
func get_target_position() -> Vector2:
	return __target_position
