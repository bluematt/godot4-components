@icon("./look_at_node.svg")
class_name BBLookAtNode
extends "res://addons/bb-components/follower_component.gd"

## Rotate a [Node2D] to "look" at another [Node2D].

## The node to follow.
@export var follow_node : Node2D:
	set=set_follow_node, get=get_follow_node

## Set [member follow_node].
func set_follow_node(_node : Node2D) -> void: follow_node = _node

## Get [member follow_node].
func get_follow_node() -> Node2D: return follow_node
	
func _ready() -> void:
	super()
	assert(follow_node, ("No follow_node:Node2D component specified in %s.") 
		% [str(get_path())])

func _process(_delta: float) -> void:
	__look_at(follow_node.global_position)
