@icon("./align_to_velocity.svg")
class_name BBAlignToVelocity
extends "res://addons/bb-components/follower_component.gd"

## Align a [Node2D]'s rotation to follow a [BBVelocity].

## The [BBVelocity] component to align to.  Automatically assigned if unset and
## a child of a [BBVelocity] component.
@export var velocity_node : BBVelocity:
	set=set_velocity_node, get=get_velocity_node

## Set [member velocity_node].
func set_velocity_node(_node : BBVelocity) -> void: velocity_node = _node

## Get [member velocity_node].
func get_velocity_node() -> BBVelocity: return velocity_node

func _ready() -> void:
	super()

	if null == velocity_node:
		velocity_node = get_parent() as BBVelocity
	assert(velocity_node, ("No velocity_node:BBVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child "
		+ "of a BBVelocity component.") % [str(get_path())])

func _physics_process(_delta: float) -> void:
	if enabled:
		if velocity_node.get_direction():
			object_node.rotation = lerp_angle(object_node.rotation, 
				velocity_node.get_direction().angle(), smoothing)
