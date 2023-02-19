@icon("res://icons/movement_controls_left_right.svg")
class_name MovementControlsLeftRight
extends Node

## Applies left and right movement to a [MovementVelocity] component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsLeftRight.md

# The default input action for left movement.
const DEFAULT_ACTION_LEFT := "ui_left"

# The default input action for right movement.
const DEFAULT_ACTION_RIGHT := "ui_right"

## The [MovementVelocity] to control.
@export var velocity_node: MovementVelocity

@export_group("Input actions", "input_action_")

## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as MovementVelocity
	assert(velocity_node, "No velocity_node:MovementVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a MovementVelocity component." % [get_path()])

	if input_action_left == null:
		input_action_left = InputEventAction.new()
		input_action_left.set_action(DEFAULT_ACTION_LEFT)
	assert(input_action_left, "No input_action_left:InputEventAction " +
		"resource specified in %s." % [get_path()])
	assert(input_action_left.action, "No input_action_left.action " + 
		"specified in %s." % [get_path()])

	if input_action_right == null:
		input_action_right = InputEventAction.new()
		input_action_right.set_action(DEFAULT_ACTION_RIGHT)
	assert(input_action_right, "No input_action_right:InputEventAction " +
		"resource specified in %s." % [get_path()])
	assert(input_action_right.action, "No input_action_right.action " + 
		"specified in %s." % [get_path()])


func _process(_delta: float) -> void:
	velocity_node.direction.x = Input.get_axis(
		input_action_left.action,
		input_action_right.action)
