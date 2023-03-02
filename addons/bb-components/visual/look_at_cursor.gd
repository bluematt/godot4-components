@icon("./look_at_cursor.svg")
class_name BBLookAtCursor
extends Node

## Rotates a Node2D to "look" at the cursor.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/look_at_cursor.md

## The node to rotate.
@export var node:Node2D

## The smoothing to be applied to the rotation.
@export_range(0.0, 1.0) var smoothing := 1.0

## Whether the component is enabled.
@export var enabled := true

# The interpolated cursor position.
var __cursor_position:Vector2

func _ready() -> void:
	if not node:
		node = get_parent()
	assert(node, ("No node:Node2D component specified in %s. Select one, or reparent this " +
		"component as a child of a Node2D node.") % [str(get_path())])

	__cursor_position = node.get_global_mouse_position()

func _process(_delta: float) -> void:
	if enabled:
		__cursor_position = lerp(__cursor_position, node.get_global_mouse_position(), smoothing)
		node.look_at(__cursor_position)
