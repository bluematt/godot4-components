@icon("./icon.svg")
extends BaseComponent
class_name BaseControlsComponent

## A base for controls components.

## The default input action for up movement.
const DEFAULT_ACTION_UP := &"ui_up"

## The default input action for down movement.
const DEFAULT_ACTION_DOWN := &"ui_down"

## The default input action for left movement.
const DEFAULT_ACTION_LEFT := &"ui_left"

## The default input action for right movement.
const DEFAULT_ACTION_RIGHT := &"ui_right"

## The [VelocityComponent] component to control.
var velocity_component: VelocityComponent
	
func _ready() -> void:
	velocity_component = get_parent() as VelocityComponent

	assert(velocity_component, "BaseControlsComponent must be a child of a VelocityComponent in %s." % [str(get_path())])
