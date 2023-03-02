@icon("./controls_four_way.svg")
class_name BBControlsFourWay
extends Node

## Applies directional four-way movement to a [BBVelocity] component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/controls_four_way.md

## The default input action for up movement.
const DEFAULT_ACTION_UP := &"ui_up"

## The default input action for down movement.
const DEFAULT_ACTION_DOWN := &"ui_down"

## The default input action for left movement.
const DEFAULT_ACTION_LEFT := &"ui_left"

## The default input action for right movement.
const DEFAULT_ACTION_RIGHT := &"ui_right"

## The [BBVelocity] component to control.
@export var velocity_node: BBVelocity

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
		velocity_node = get_parent() as BBVelocity
	assert(velocity_node, ("No velocity_node:BBVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child "
		+ "of a BBVelocity component.") % [str(get_path())])
	
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
	velocity_node.set_direction(Input.get_vector(
		input_action_left.action, 
		input_action_right.action,
		input_action_up.action,
		input_action_down.action))

## Set the [member velocity_node].
func set_velocity(new_velocity : BBVelocity) -> void:
	velocity_node = new_velocity

## Return the [member velocity_node].
func get_velocity() -> BBVelocity:
	return velocity_node

## Set the [InputEventAction] to move up.
func set_input_action_up(new_action : InputEventAction) -> void:
	input_action_up = new_action

# Get the [InputEventAction] to move up.
func get_input_action_up() -> InputEventAction:
	return input_action_up
	
## Set the [InputEventAction] to move down.
func set_input_action_down(new_action : InputEventAction) -> void:
	input_action_down = new_action
	
# Get the [InputEventAction] to move down.
func get_input_action_down() -> InputEventAction:
	return input_action_down
	
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
	
## Set the action to move up.
func set_action_up(new_action : StringName) -> void:
	input_action_up.set_action(new_action)
	
## Get the action to move up.
func get_action_up() -> StringName:
	return input_action_up.get_action()

## Set the action to move down.
func set_action_down(new_action : StringName) -> void:
	input_action_down.set_action(new_action)

## Get the action to move down.
func get_action_down() -> StringName:
	return input_action_down.get_action()

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

## Reset all actions to their defaults.	
func reset_actions() -> void:
	reset_action_up()
	reset_action_down()
	reset_action_left()
	reset_action_right()

## Reset the default name of the action to move up.
func reset_action_up() -> void:
	input_action_up = InputEventAction.new()
	set_action_up(DEFAULT_ACTION_UP)

## Reset the action to move down.
func reset_action_down() -> void:
	input_action_down = InputEventAction.new()
	set_action_down(DEFAULT_ACTION_DOWN)

## Reset the action to move left.
func reset_action_left() -> void:
	input_action_left = InputEventAction.new()
	set_action_left(DEFAULT_ACTION_LEFT)

## Reset the action to move right.
func reset_action_right() -> void:
	input_action_right = InputEventAction.new()
	set_action_right(DEFAULT_ACTION_RIGHT)
