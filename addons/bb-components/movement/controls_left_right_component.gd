@icon("./controls_left_right_component.svg")
extends BaseControlsComponent
class_name ControlsLeftRightComponent

## Apply left/right movement to a [VelocityComponent].

## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	super()

	if null == input_action_left:
		reset_action_left()

	if null == input_action_right:
		reset_action_right()

func _process(_delta: float) -> void:
	velocity_component.direction.x = Input.get_axis(input_action_left.action, input_action_right.action)
	
## Reset the action to move left.
func reset_action_left() -> void:
	input_action_left = InputEventAction.new()
	input_action_left.action = DEFAULT_ACTION_LEFT

## Reset the action to move right.
func reset_action_right() -> void:
	input_action_right = InputEventAction.new()
	input_action_right.action = DEFAULT_ACTION_RIGHT
