@icon("./bounce_component.svg")
extends TweenedComponent
class_name BounceComponent

## Add a simple bouncing effect to a [Node2D].
##
## Attach the component to a [Node2D] to make it bounce.

## How far to move the node from its original position (in pixels).
@export var displacement := Vector2.ZERO

# The node to bounce.
var _target_node: Node2D

# The original position of the node.
var _original_position: Vector2

func _ready() -> void:
	super()

	# Assign the target node.	
	_target_node = get_parent() as Node2D
	assert(_target_node, "BounceComponent must be a child of a Node2D node in %s." % [str(get_path())])

	# Record the target node's original position so that we can tween back to it.
	_original_position = _target_node.position
	
	# Start the tween if the component is enabled.
	if enabled:
		start.call_deferred()

## Define the tween for this component.
func define_tween() -> void:
	# Determine the tween's final target position.
	var target_position := _original_position + displacement

	# Set up the first part of the tween to move to the target position.
	get_tween().tween_property(_target_node, "position", target_position,
		duration)

	# Determine how to loop this tween.
	match loop:
		# If it loops from the start, go back to the original position instantly.
		Loop.FROM_START:
			get_tween().tween_property(_target_node, "position",
				_original_position, NO_DURATION)
		# If it ping-pongs, tween back to the original position.
		Loop.PING_PONG:
			get_tween().tween_property(_target_node, "position",
				_original_position, duration)
		_:
			pass
