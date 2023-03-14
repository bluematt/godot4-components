@icon("./controls_up_down_component.svg")
extends BaseControlsComponent
class_name ControlsUpDownComponent

## Apply up/down movement to a [VelocityComponent].

## The input action to move up.
@export var input_action_up:InputEventAction

## The input action to move down.
@export var input_action_down:InputEventAction

func _ready() -> void:
	super()

	if null == input_action_up:
		reset_action_up()

	if null == input_action_down:
		reset_action_down()

func _process(_delta: float) -> void:
	velocity_component.direction.y = Input.get_axis(input_action_up.action, input_action_down.action)

## Reset the default name of the action to move up.
func reset_action_up() -> void:
	input_action_up = InputEventAction.new()
	input_action_up.action = DEFAULT_ACTION_UP

## Reset the action to move down.
func reset_action_down() -> void:
	input_action_down = InputEventAction.new()
	input_action_down.action = DEFAULT_ACTION_DOWN
