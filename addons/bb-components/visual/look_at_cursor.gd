@icon("./look_at_cursor.svg")
class_name BBLookAtCursor
extends Node

## Rotates a Node2D to "look" at the cursor.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/look_at_cursor.md

## Emitted when the [member object_node] is looking towards the cursor (or 
## close to it).
signal looked_at(target : Vector2)

## Emitted when the [member object_node] is looking [i]directly[/i] at the
## cursor.
signal looked_directly_at(target : Vector2)

## The node to rotate.
@export var object_node:Node2D

## The smoothing to be applied to the rotation.
@export_range(0.0, 1.0) var smoothing := 1.0

## Whether the component is enabled.
@export var enabled := true

# The interpolated cursor position.
var __cursor_position:Vector2

func _ready() -> void:
	if not object_node:
		object_node = get_parent()
	assert(object_node, ("No object_node:Node2D component specified in %s. " +
		"Select one, or reparent this component as a child of a Node2D node.")
		% [str(get_path())])

	__cursor_position = object_node.get_global_mouse_position()

func _process(_delta: float) -> void:
	if enabled:
		# Keep track of the old cursor position so we can check later if we need
		# to emit signals.
		var old_cursor_position := __cursor_position
		var cursor_position := object_node.get_global_mouse_position()
		
		# Look towards the cursor.
		__cursor_position = lerp(__cursor_position, cursor_position, smoothing)
		object_node.look_at(__cursor_position)
		
		# Emit signals if required.
		if old_cursor_position != __cursor_position:
			if __cursor_position.is_equal_approx(cursor_position):
				looked_at.emit(__cursor_position)
			if __cursor_position == cursor_position:
				looked_directly_at.emit(__cursor_position)

## Set the node to rotate.
func set_object_node(node : Node2D) -> void:
	object_node = node

## Get the node to rotate.
func get_object_node() -> Node2D:
	return object_node

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
func get_cursor_position() -> Vector2:
	return __cursor_position
