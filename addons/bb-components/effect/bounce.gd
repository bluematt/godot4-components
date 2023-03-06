@icon("./bounce.svg")
class_name BBBounce
extends "res://addons/bb-components/tweened_component.gd"

## Add a simple bouncing effect to a [Node2D].

## The node to bounce.
@export var bouncing_node : Node2D:
	set=set_bouncing_node, get=get_bouncing_node

## Set [member bouncing_node].
func set_bouncing_node(_node : Node2D) -> void: bouncing_node = _node

## Get [member bouncing_node].
func get_bouncing_node() -> Node2D: return bouncing_node

## How far to move the node from its original position (in pixels).
@export var displacement := Vector2.ZERO:
	set=set_displacement, get=get_displacement

## Set [member displacement].
func set_displacement(_displacement : Vector2) -> void:
	displacement = _displacement

## Get [member displacement].
func get_displacement() -> Vector2: return displacement

# The original position of the node.
var __original_position : Vector2

func _ready() -> void:
	super()
	
	if null == bouncing_node:
		bouncing_node = get_parent()
	assert(bouncing_node, ("No bouncing_node:Node2D node specified in %s. " +
		"Select one, or reparent this component as a child of a Node2D node.")
		% [str(get_path())])

	__original_position = bouncing_node.position
	
	if enabled: start.call_deferred()

func define_tween() -> void:
	var target_position := __original_position + displacement

	get_tween().tween_property(bouncing_node, "position", target_position,
		duration)

	match loop:
		Loop.FROM_START:
			get_tween().tween_property(bouncing_node, "position",
				__original_position, NO_DURATION)
		Loop.PING_PONG:
			get_tween().tween_property(bouncing_node, "position",
				__original_position, duration)
		_:
			pass
