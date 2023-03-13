@icon("./controls_left_right.svg")
class_name BBControlsLeftRight
extends "res://addons/bb-components/controls_component.gd"

## Apply left/right movement to a [VelocityComponent].

## The input action to move left.
@export var input_action_left:InputEventAction:
	set=set_input_action_left, get=get_input_action_left

## Set the [InputEventAction] to move left.
func set_input_action_left(_event_action : InputEventAction) -> void:
	input_action_left = _event_action
	
# Get the [InputEventAction] to move left.
func get_input_action_left() -> InputEventAction: return input_action_left

## The input action to move right.
@export var input_action_right:InputEventAction:
	set=set_input_action_right, get=get_input_action_right

## Set the [InputEventAction] to move right.
func set_input_action_right(_event_action : InputEventAction) -> void:
	input_action_right = _event_action
	
# Get the [InputEventAction] to move right.
func get_input_action_right() -> InputEventAction: return input_action_right

func _ready() -> void:
	super()

	if null == input_action_left:
		reset_action_left()
	assert(input_action_left, ("No input_action_left:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_left.action, ("No input_action_left.action " + 
		"specified in %s.") % [str(get_path())])

	if null == input_action_right:
		reset_action_right()
	assert(input_action_right, ("No input_action_right:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_right.action, ("No input_action_right.action " + 
		"specified in %s.") % [str(get_path())])

func _process(_delta: float) -> void:
	velocity_node.set_x_direction(Input.get_axis(
		input_action_left.action, input_action_right.action))
	
## Set the action to move left.
func set_action_left(_action : StringName) -> void:
	input_action_left.set_action(_action)

## Get the action to move left.
func get_action_left() -> StringName:
	return input_action_left.get_action()

## Set the action to move right.
func set_action_right(_action : StringName) -> void:
	input_action_right.set_action(_action)

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
