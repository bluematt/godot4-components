@icon("./controls_four_way_component.svg")
extends BaseControlsComponent
class_name ControlsFourWayComponent

## Apply four-way movement to a [VelocityComponent].

## The input action to move up.
@export var input_action_up:InputEventAction

## The input action to move down.
@export var input_action_down:InputEventAction
	
## The input action to move left.
@export var input_action_left:InputEventAction

## The input action to move right.
@export var input_action_right:InputEventAction

func _ready() -> void:
	super()
	
	if null == input_action_up:
		reset_action_up()

	if null == input_action_down:
		reset_action_down()
	
	if null == input_action_left:
		reset_action_left()

	if null == input_action_right:
		reset_action_right()

func _process(_delta: float) -> void:
	velocity_component.direction = Input.get_vector(input_action_left.action, input_action_right.action, input_action_up.action, input_action_down.action)

## Reset the default name of the action to move up.
func reset_action_up() -> void:
	input_action_up = InputEventAction.new()
	input_action_up.action = DEFAULT_ACTION_UP

## Reset the action to move down.
func reset_action_down() -> void:
	input_action_down = InputEventAction.new()
	input_action_down.action = DEFAULT_ACTION_DOWN

## Reset the action to move left.
func reset_action_left() -> void:
	input_action_left = InputEventAction.new()
	input_action_left.action = DEFAULT_ACTION_LEFT

## Reset the action to move right.
func reset_action_right() -> void:
	input_action_right = InputEventAction.new()
	input_action_right.action = DEFAULT_ACTION_RIGHT
