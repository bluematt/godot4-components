---
component: ControlsFourWayComponent
class_name: BCControlsFourWay
---

# <img src="../addons/bc-components/movement/controls_four_way.svg" width="48" height="48"> `ControlsFourWayComponent`

Class: `BCControlsFourWay`

Apply four-way movement to a [`VelocityComponent`](velocity.md).

If attached directly to a `VelocityComponent`, `velocity_node` does not need to be assigned.

The `ControlsFourWayComponent` is, by default, mapped to the `ui_up`, `ui_down`, `ui_left`, and `ui_right` actions.  Other actions can be assigned, but they should first be defined in the Input Map (within Project Settings).

## API

### Constants

- `DEFAULT_ACTION_UP = &"ui_up"` - The name of the default action for up movement.
- `DEFAULT_ACTION_DOWN = &"ui_down"` - The name of the default action for down movement.
- `DEFAULT_ACTION_LEFT = &"ui_left"` - The name of the default action for left movement.
- `DEFAULT_ACTION_RIGHT = &"ui_right"` - The name of the default action for right movement.

### Properties

- `velocity_node : BCVelocity` - The `VelocityComponent` to control.
- `input_action_up : InputEventAction` - The input action to move up.
- `input_action_down : InputEventAction` - The input action to move down.
- `input_action_left : InputEventAction` - The input action to move left.
- `input_action_right : InputEventAction` - The input action to move right.

### Methods

- `set_velocity(value : BCVelocity)` - Set the `velocity_node`.
- `get_velocity() -> BCVelocity` - Return the `velocity_node`.
- `set_input_action_up(value : InputEventAction)` - Set the `InputEventAction` to move up.
- `set_input_action_down(value : InputEventAction)` - Set the `InputEventAction` to move down.
- `set_input_action_left(value : InputEventAction)` - Set the `InputEventAction` to move left.
- `set_input_action_right(value : InputEventAction)` - Set the `InputEventAction` to move right.
- `set_action_up(value : StringName)` - Set the name of the action to move up.
- `set_action_down(value : StringName)` - Set the name of the action to move down.
- `set_action_left(value : StringName)` - Set the name of the action to move left.
- `set_action_right(value : StringName)` - Set the name of the action to move right.
- `reset_actions()` - Reset all actions to their defaults.
- `reset_action_up()` - Reset the default name of the action to move up.
- `reset_action_down()` - Reset the default name of the action to move down.
- `reset_action_left()` - Reset the default name of the action to move left.
- `reset_action_right()` - Reset the default name of the action to move right.

### Related components

@TODO

- [`VelocityComponent`](velocity.md) - Description.
- [`ControlsUpDownComponent`](controls_up_down.md) - Description.
- [`ControlsLeftRightComponent`](controls_left_right.md) - Description.

