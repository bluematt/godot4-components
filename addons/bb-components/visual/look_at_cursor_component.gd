@icon("./look_at_cursor.svg")
class_name BBLookAtCursor
extends "res://addons/bb-components/follower_component.gd"

## Rotate a [Node2D] to "look" at the cursor.

func _ready() -> void:
	super()

func _process(_delta: float) -> void:
	_look_at(object_node.get_global_mouse_position())
