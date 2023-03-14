@icon("./rotate_component.svg")
extends BaseComponent
class_name RotateComponent

## Rotate a [Node2D] at a constant angular speed.

# The node to rotate.
var _target_node: Node2D

## Rotation speed (degrees per second).
@export_range(-360.0, 360.0, 0.01, "suffix:°/s", "or_less", "or_greater") var rotation_speed := 0.0
	
func _ready() -> void:
	super()

	# Assign the target node.	
	_target_node = get_parent()
	assert(_target_node, "RotateComponent must be a child of a Node2D node in %s." % [str(get_path())])

func _process(delta: float) -> void:
	if enabled:
		_target_node.rotation_degrees += rotation_speed * delta
