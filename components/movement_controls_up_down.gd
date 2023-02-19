@icon("res://icons/movement_controls_up_down.svg")
class_name MovementControlsUpDown
extends Node

## Applies up and down movement to a [MovementVelocity] component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsUpDown.md

# The default input action for up movement.
const DEFAULT_ACTION_UP := "ui_up"

# The default input action for down movement.
const DEFAULT_ACTION_DOWN := "ui_down"

## The [MovementVelocity] to control.
@export var velocity_node: MovementVelocity

@export_group("Input actions", "input_action_")

## The input action to move up.
@export var input_action_up:InputEventAction

## The input action to move down.
@export var input_action_down:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as MovementVelocity
	assert(velocity_node, "No velocity_node:MovementVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a MovementVelocity component." % [get_path()])

	if input_action_up == null:
		input_action_up = InputEventAction.new()
		input_action_up.set_action(DEFAULT_ACTION_UP)
	assert(input_action_up, "No input_action_up:InputEventAction resource " + 
		"specified in %s." % [get_path()])
	assert(input_action_up.action, "No input_action_up.action " + 
		"specified in %s." % [get_path()])

	if input_action_down == null:
		input_action_down = InputEventAction.new()
		input_action_down.set_action(DEFAULT_ACTION_DOWN)
	assert(input_action_down, "No input_action_down:InputEventAction " +
		"resource specified in %s." % [get_path()])
	assert(input_action_down.action, "No input_action_down.action " + 
		"specified in %s." % [get_path()])

func _process(_delta: float) -> void:
	velocity_node.direction.y = Input.get_axis(
		input_action_up.action,
		input_action_down.action)
