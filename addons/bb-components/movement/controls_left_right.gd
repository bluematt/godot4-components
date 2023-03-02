@icon("./controls_left_right.svg")
class_name BBControlsLeftRight
extends Node

## Applies left and right movement to a [BBVelocity] component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/controls_left_right.md

## The default input action for left movement.
const DEFAULT_ACTION_LEFT := &"ui_left"

## The default input action for right movement.
const DEFAULT_ACTION_RIGHT := &"ui_right"

## The [BBVelocity] component to control.
@export var velocity_node: BBVelocity

@export_group("Input actions", "input_action_")

## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as BBVelocity
	assert(velocity_node, ("No velocity_node:BBVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBVelocity component.") % [str(get_path())])

	if input_action_left == null:
		reset_action_left()
	assert(input_action_left, ("No input_action_left:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_left.action, ("No input_action_left.action " + 
		"specified in %s.") % [str(get_path())])

	if input_action_right == null:
		reset_action_right()
	assert(input_action_right, ("No input_action_right:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_right.action, ("No input_action_right.action " + 
		"specified in %s.") % [str(get_path())])

func _process(_delta: float) -> void:
	velocity_node.set_direction_x(Input.get_axis(
		input_action_left.action, input_action_right.action))

## Set the [member velocity_node].
func set_velocity(new_velocity : BBVelocity) -> void:
	velocity_node = new_velocity

## Return the [member velocity_node].
func get_velocity() -> BBVelocity:
	return velocity_node

## Set the [InputEventAction] to move left.
func set_input_action_left(new_action : InputEventAction) -> void:
	input_action_left = new_action
	
# Get the [InputEventAction] to move left.
func get_input_action_left() -> InputEventAction:
	return input_action_left
	
## Set the [InputEventAction] to move right.
func set_input_action_right(new_action : InputEventAction) -> void:
	input_action_right = new_action
	
# Get the [InputEventAction] to move right.
func get_input_action_right() -> InputEventAction:
	return input_action_right
	
## Set the action to move left.
func set_action_left(new_action : StringName) -> void:
	input_action_left.set_action(new_action)

## Get the action to move left.
func get_action_left() -> StringName:
	return input_action_left.get_action()

## Set the action to move right.
func set_action_right(new_action : StringName) -> void:
	input_action_right.set_action(new_action)

## Get the action to move right.
func get_action_right() -> StringName:
	return input_action_right.get_action()
	
## Reset all actions.	
func reset_actions() -> void:
	reset_action_left()
	reset_action_right()

## Reset the action to move left.
func reset_action_left() -> void:
	input_action_left = InputEventAction.new()
	set_action_left(DEFAULT_ACTION_LEFT)

## Reset the action to move right.
func reset_action_right() -> void:
	input_action_right = InputEventAction.new()
	set_action_right(DEFAULT_ACTION_RIGHT)
