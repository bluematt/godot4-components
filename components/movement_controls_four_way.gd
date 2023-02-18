class_name MovementControlsFourWay
extends Node

## Applies directional four-way movement to a [MovementVelocity] component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementControlsFourWay.md

# The default input action for up movement.
const DEFAULT_ACTION_UP := "ui_up"

# The default input action for down movement.
const DEFAULT_ACTION_DOWN := "ui_down"

# The default input action for left movement.
const DEFAULT_ACTION_LEFT := "ui_left"

# The default input action for right movement.
const DEFAULT_ACTION_RIGHT := "ui_right"

## The [MovementVelocity] to control.
@export var velocity_node: MovementVelocity

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
		velocity_node = get_parent() as MovementVelocity
	assert(velocity_node)
	
	if input_action_up == null:
		input_action_up = InputEventAction.new()
		input_action_up.set_action(DEFAULT_ACTION_UP)
	assert(input_action_up)

	if input_action_down == null:
		input_action_down = InputEventAction.new()
		input_action_down.set_action(DEFAULT_ACTION_DOWN)
	assert(input_action_down)
	
	if input_action_left == null:
		input_action_left = InputEventAction.new()
		input_action_left.set_action(DEFAULT_ACTION_LEFT)
	assert(input_action_left)

	if input_action_right == null:
		input_action_right = InputEventAction.new()
		input_action_right.set_action(DEFAULT_ACTION_RIGHT)
	assert(input_action_right)

func _process(_delta: float) -> void:
	velocity_node.direction = Input.get_vector(
		input_action_left.action, 
		input_action_right.action,
		input_action_up.action,
		input_action_down.action)
