@icon("./look_at_cursor_component.svg")
extends FollowerComponent
class_name LookAtCursorComponent

## Rotate a [Node2D] to "look" at the cursor.

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	_look_at(owner.get_global_mouse_position(), delta)
