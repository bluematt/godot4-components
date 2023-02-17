class_name MovementControlsLeftRight
extends Node

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
		input_action_left.set_action("ui_left")
	assert(input_action_left)

	if input_action_right == null:
		input_action_right = InputEventAction.new()
		input_action_right.set_action("ui_right")
	assert(input_action_right)


func _process(_delta: float) -> void:
	velocity_node.direction.x = Input.get_axis(
		input_action_left.action,
		input_action_right.action)
