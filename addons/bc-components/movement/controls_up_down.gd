@icon("./controls_up_down.svg")
class_name BCControlsUpDown
extends Node

## Applies up and down movement to a [BCVelocity].
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsUpDown.md

## The default input action for up movement.
const DEFAULT_ACTION_UP := "ui_up"

## The default input action for down movement.
const DEFAULT_ACTION_DOWN := "ui_down"

## The [BCVelocity] to control.
@export var velocity_node: BCVelocity

@export_group("Input actions", "input_action_")

## The input action to move up.
@export var input_action_up:InputEventAction

## The input action to move down.
@export var input_action_down:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as BCVelocity
	assert(velocity_node, ("No velocity_node:BCVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BCVelocity component.") % [str(get_path())])

	if input_action_up == null:
		reset_action_up()
	assert(input_action_up, ("No input_action_up:InputEventAction resource " + 
		"specified in %s.") % [str(get_path())])
	assert(input_action_up.action, ("No input_action_up.action " + 
		"specified in %s.") % [str(get_path())])

	if input_action_down == null:
		reset_action_down()
	assert(input_action_down, ("No input_action_down:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_down.action, ("No input_action_down.action " + 
		"specified in %s.") % [str(get_path())])

func _process(_delta: float) -> void:
	velocity_node.set_direction_y(Input.get_axis(
		input_action_up.action, input_action_down.action))

## Set the [member velocity_node].
func set_velocity(value : BCVelocity) -> void:
	velocity_node = value

## Return the [member velocity_node].
func get_velocity() -> BCVelocity:
	return velocity_node

## Set the [InputEventAction] to move up.
func set_input_action_up(value : InputEventAction) -> void:
	input_action_up = value
	
## Set the [InputEventAction] to move down.
func set_input_action_down(value : InputEventAction) -> void:
	input_action_down = value
	
## Set the action to move up.
func set_action_up(value : StringName) -> void:
	input_action_up.set_action(value)

## Set the action to move down.
func set_action_down(value : StringName) -> void:
	input_action_down.set_action(value)
	
## Reset all actions.	
func reset_actions() -> void:
	reset_action_up()
	reset_action_down()

## Set the action to move up.
func reset_action_up() -> void:
	input_action_up == null
	input_action_up = InputEventAction.new()
	input_action_up.set_action(DEFAULT_ACTION_UP)

## Set the action to move down.
func reset_action_down() -> void:
	input_action_down == null
	input_action_down = InputEventAction.new()
	input_action_down.set_action(DEFAULT_ACTION_DOWN)
