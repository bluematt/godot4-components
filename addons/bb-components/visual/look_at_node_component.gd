@icon("./look_at_node_component.svg")
extends FollowerComponent
class_name LookAtNodeComponent

## Rotate a [Node2D] to "look" at another [Node2D].

## The node to look at.
@export var look_target_node: Node2D
	
func _ready() -> void:
	super()

	assert(look_target_node, "No look_target_node:Node2D component specified in %s." % [str(get_path())])

func _process(delta: float) -> void:
	_look_at(look_target_node.global_position, delta)
