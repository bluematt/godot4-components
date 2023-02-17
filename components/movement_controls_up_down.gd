class_name MovementControlsUpDown
extends Node

## Applies up and down movement to a [MovementVelocity] component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsUpDown.md

## The [MovementVelocity] to control.
@export var velocity_node: MovementVelocity
## The input action to move up.
@export var input_action_up:InputEventAction
## The input action to move down.
@export var input_action_down:InputEventAction

func _ready() -> void:
	if velocity_node == null:
		velocity_node = get_parent() as MovementVelocity
	assert(velocity_node)

	if input_action_up == null:
		input_action_up = InputEventAction.new()
		input_action_up.set_action("ui_up")
	assert(input_action_up)

	if input_action_down == null:
		input_action_down = InputEventAction.new()
		input_action_down.set_action("ui_down")
	assert(input_action_down)

func _process(_delta: float) -> void:
	velocity_node.direction.y = Input.get_axis(
		input_action_up.action,
		input_action_down.action)
