@icon("res://icons/movement_controls_four_way.svg")
class_name MovementControlsFourWay
extends Node

## Applies directional four-way movement to a [BCVelocityComponent] component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsFourWay.md

## The default input action for up movement.
const DEFAULT_ACTION_UP := "ui_up"

## The default input action for down movement.
const DEFAULT_ACTION_DOWN := "ui_down"

## The default input action for left movement.
const DEFAULT_ACTION_LEFT := "ui_left"

## The default input action for right movement.
const DEFAULT_ACTION_RIGHT := "ui_right"

## The [BCVelocityComponent] to control.
@export var velocity_node: BCVelocityComponent

@export_group("Input actions", "input_action_")

## The input action to move up.
@export var input_action_up:InputEventAction

## The input action to move down.
@export var input_action_down:InputEventAction

## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as BCVelocityComponent
	assert(velocity_node, ("No velocity_node:BCVelocityComponent component " + 
		"specified in %s. Select one, or reparent this component as a child "
		+ "of a BCVelocityComponent component.") % [str(get_path())])
	
	if input_action_up == null:
		input_action_up = InputEventAction.new()
		input_action_up.set_action(DEFAULT_ACTION_UP)
	assert(input_action_up, ("No input_action_up:InputEventAction resource " + 
		"specified in %s.") % [str(get_path())])
	assert(input_action_up.action, ("No input_action_up.action " + 
		"specified in %s.") % [str(get_path())])

	if input_action_down == null:
		input_action_down = InputEventAction.new()
		input_action_down.set_action(DEFAULT_ACTION_DOWN)
	assert(input_action_down, ("No input_action_down:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_down.action, ("No input_action_down.action " + 
		"specified in %s.") % [str(get_path())])
	
	if input_action_left == null:
		input_action_left = InputEventAction.new()
		input_action_left.set_action(DEFAULT_ACTION_LEFT)
	assert(input_action_left, ("No input_action_left:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_left.action, ("No input_action_left.action " + 
		"specified in %s.") % [str(get_path())])

	if input_action_right == null:
		input_action_right = InputEventAction.new()
		input_action_right.set_action(DEFAULT_ACTION_RIGHT)
	assert(input_action_right, ("No input_action_right:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_right.action, ("No input_action_right.action " + 
		"specified in %s.") % [str(get_path())])

func _process(_delta: float) -> void:
	velocity_node.set_direction(Input.get_vector(
		input_action_left.action, 
		input_action_right.action,
		input_action_up.action,
		input_action_down.action))

## Set the [member velocity_node].
func set_velocity(value : BCVelocityComponent) -> void:
	velocity_node = value

## Return the [member velocity_node].
func get_velocity() -> BCVelocityComponent:
	return velocity_node

## Set the [InputEventAction] to move up.
func set_input_action_up(value : InputEventAction) -> void:
	input_action_up = value
	
## Set the [InputEventAction] to move down.
func set_input_action_down(value : InputEventAction) -> void:
	input_action_down = value
	
## Set the [InputEventAction] to move left.
func set_input_action_left(value : InputEventAction) -> void:
	input_action_left = value
	
## Set the [InputEventAction] to move right.
func set_input_action_right(value : InputEventAction) -> void:
	input_action_right = value
	
## Set the action to move up.
func set_action_up(value : StringName) -> void:
	input_action_up.set_action(value)

## Set the action to move down.
func set_action_down(value : StringName) -> void:
	input_action_down.set_action(value)

## Set the action to move left.
func set_action_left(value : StringName) -> void:
	input_action_left.set_action(value)

## Set the action to move right.
func set_action_right(value : StringName) -> void:
	input_action_right.set_action(value)

## Reset all actions.	
func reset_actions() -> void:
	reset_action_up()
	reset_action_down()
	reset_action_left()
	reset_action_right()

## Reset the action to move up.
func reset_action_up() -> void:
	input_action_up == null
	input_action_up = InputEventAction.new()
	input_action_up.set_action(DEFAULT_ACTION_UP)

## Reset the action to move down.
func reset_action_down() -> void:
	input_action_down == null
	input_action_down = InputEventAction.new()
	input_action_down.set_action(DEFAULT_ACTION_DOWN)

## Reset the action to move left.
func reset_action_left() -> void:
	input_action_left == null
	input_action_left = InputEventAction.new()
	input_action_left.set_action(DEFAULT_ACTION_LEFT)

## Reset the action to move right.
func reset_action_right() -> void:
	input_action_right == null
	input_action_right = InputEventAction.new()
	input_action_right.set_action(DEFAULT_ACTION_RIGHT)
