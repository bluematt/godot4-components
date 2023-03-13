extends "res://addons/bb-components/base_component.gd"

## A base for controls components.

## The default input action for up movement.
const DEFAULT_ACTION_UP := &"ui_up"

## The default input action for down movement.
const DEFAULT_ACTION_DOWN := &"ui_down"

## The default input action for left movement.
const DEFAULT_ACTION_LEFT := &"ui_left"

## The default input action for right movement.
const DEFAULT_ACTION_RIGHT := &"ui_right"

@export_category("ControlsComponent")

## The [VelocityComponent] component to control.
@export var velocity_node: VelocityComponent:
	set=set_velocity_node, get=get_velocity_node

## Set [member velocity_node].
func set_velocity_node(_node : VelocityComponent) -> void:
	velocity_node = _node

## Get [member velocity_node].
func get_velocity_node() -> VelocityComponent:
	return velocity_node
	
func _ready() -> void:
	if null == velocity_node:
		velocity_node = get_parent() as VelocityComponent
	assert(velocity_node, ("No velocity_node:VelocityComponent component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a VelocityComponent component.") % [str(get_path())])

## Reset all actions to their defaults.	
func reset_actions() -> void:
	assert(false, "reset_actions() should be overloaded in the derived class.")
