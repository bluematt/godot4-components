@icon("res://icons/movement_controls_left_right.svg")
class_name MovementControlsLeftRight
extends Node

## Applies left and right movement to a [BCVelocityComponent] component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsLeftRight.md

## The default input action for left movement.
const DEFAULT_ACTION_LEFT := &"ui_left"

## The default input action for right movement.
const DEFAULT_ACTION_RIGHT := &"ui_right"

## The [BCVelocityComponent] to control.
@export var velocity_node: BCVelocityComponent

@export_group("Input actions", "input_action_")

## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as BCVelocityComponent
	assert(velocity_node, ("No velocity_node:BCVelocityComponent component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BCVelocityComponent component.") % [str(get_path())])

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
func set_velocity(value : BCVelocityComponent) -> void:
	velocity_node = value

## Return the [member velocity_node].
func get_velocity() -> BCVelocityComponent:
	return velocity_node

## Set the [InputEventAction] to move left.
func set_input_action_left(value : InputEventAction) -> void:
	input_action_left = value
	
## Set the [InputEventAction] to move right.
func set_input_action_right(value : InputEventAction) -> void:
	input_action_right = value
	
## Set the action to move left.
func set_action_left(value : StringName) -> void:
	input_action_left.set_action(value)

## Set the action to move right.
func set_action_right(value : StringName) -> void:
	input_action_right.set_action(value)
	
## Reset all actions.	
func reset_actions() -> void:
	reset_action_left()
	reset_action_right()

## Set the action to move left.
func reset_action_left() -> void:
	input_action_left == null
	input_action_left = InputEventAction.new()
	input_action_left.set_action(DEFAULT_ACTION_LEFT)

## Set the action to move right.
func reset_action_right() -> void:
	input_action_right == null
	input_action_right = InputEventAction.new()
	input_action_right.set_action(DEFAULT_ACTION_RIGHT)
