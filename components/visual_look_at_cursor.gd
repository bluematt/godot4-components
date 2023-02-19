@icon("res://icons/visual_look_at_cursor.svg")
class_name VisualLookAtCursor
extends Node

## Rotates a Node2D to "look" at the cursor.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/VisualLookAtCursor.md

# The default smoothing.
const __DEFAULT_SMOOTHING := 1.0

# The default enabled.
const __DEFAULT_ENABLED := true

# The lower smoothing limit.
const __SMOOTHING_LOWER_LIMIT := 0.0

# The upper smoothing limit.
const __SMOOTHING_UPPER_LIMIT := 1.0

## The node to rotate.
@export var node:Node2D

## The smoothing to be applied to the rotation.
@export_range(__SMOOTHING_LOWER_LIMIT, __SMOOTHING_UPPER_LIMIT) var smoothing := __DEFAULT_SMOOTHING

## Whether the component is enabled.
@export var enabled := __DEFAULT_ENABLED

## The interpolated cursor position.
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
