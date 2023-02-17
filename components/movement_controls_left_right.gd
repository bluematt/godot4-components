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

## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as MovementVelocity
	assert(velocity_node)

	if input_action_left == null:
		input_action_left = InputEventAction.new()
		input_action_left.set_action(DEFAULT_ACTION_LEFT)
	assert(input_action_left)

	if input_action_right == null:
		input_action_right = InputEventAction.new()
		input_action_right.set_action(DEFAULT_ACTION_RIGHT)
	assert(input_action_right)


func _process(_delta: float) -> void:
	velocity_node.direction.x = Input.get_axis(
		input_action_left.action,
		input_action_right.action)
