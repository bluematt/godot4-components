@icon("./controls_four_way.svg")
class_name BBControlsFourWay
extends "res://addons/bb-components/controls_component.gd"

## Apply four-way movement to a [VelocityComponent].

## The input action to move up.
@export var input_action_up:InputEventAction:
	set=set_input_action_up, get=get_input_action_up

## Set the [InputEventAction] to move up.
func set_input_action_up(_event_action : InputEventAction) -> void:
	input_action_up = _event_action

# Get the [InputEventAction] to move up.
func get_input_action_up() -> InputEventAction: return input_action_up

## The input action to move down.
@export var input_action_down:InputEventAction:
	set=set_input_action_down, get=get_input_action_down

## Set the [InputEventAction] to move down.
func set_input_action_down(_event_action : InputEventAction) -> void:
	input_action_down = _event_action
	
# Get the [InputEventAction] to move down.
func get_input_action_down() -> InputEventAction: return input_action_down
	
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
	
	if null == input_action_up:
		reset_action_up()
	assert(input_action_up, ("No input_action_up:InputEventAction resource " + 
		"specified in %s.") % [str(get_path())])
	assert(input_action_up.action, ("No input_action_up.action " + 
		"specified in %s.") % [str(get_path())])

	if null == input_action_down:
		reset_action_down()
	assert(input_action_down, ("No input_action_down:InputEventAction " +
		"resource specified in %s.") % [str(get_path())])
	assert(input_action_down.action, ("No input_action_down.action " + 
		"specified in %s.") % [str(get_path())])
	
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
	velocity_node.set_direction(Input.get_vector(
		input_action_left.action, 
		input_action_right.action,
		input_action_up.action,
		input_action_down.action))

## Set the action to move up.
func set_action_up(_action : StringName) -> void:
	input_action_up.set_action(_action)
	
## Get the action to move up.
func get_action_up() -> StringName:
	return input_action_up.get_action()

## Set the action to move down.
func set_action_down(_action : StringName) -> void:
	input_action_down.set_action(_action)

## Get the action to move down.
func get_action_down() -> StringName:
	return input_action_down.get_action()

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
