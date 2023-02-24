---
component: ControlsUpDownComponent
class_name: BBControlsUpDown
---

# <img src="../addons/bc-components/movement/controls_four_way.svg" width="48" height="48"> `ControlsUpDownComponent`

Class: `BBControlsUpDown`

Apply up and down movement to a [`VelocityComponent`](velocity.md).

If attached directly to a `VelocityComponent`, `velocity_node` does not need to be assigned.

The `ControlsUpDownComponent` is, by default, mapped to the `ui_up` and `ui_down` actions.  Other actions can be assigned, but they should first be defined in the Input Map (within Project Settings).

## API

### Constants

- `DEFAULT_ACTION_UP = &"ui_up"` - The name of the default action for up movement.
- `DEFAULT_ACTION_DOWN = &"ui_down"` - The name of the default action for down movement.

### Properties

- `velocity_node : BCVelocity` - The `VelocityComponent` to control.
- `input_action_up : InputEventAction` - The input action to move up.
- `input_action_down : InputEventAction` - The input action to move down.

### Methods

- `set_velocity(value : BCVelocity)` - Set the `velocity_node`.
- `get_velocity() -> BCVelocity` - Return the `velocity_node`.
- `set_input_action_up(value : InputEventAction)` - Set the `InputEventAction` to move up.
- `set_input_action_down(value : InputEventAction)` - Set the `InputEventAction` to move down.
- `set_action_up(value : StringName)` - Set the name of the action to move up.
- `set_action_down(value : StringName)` - Set the name of the action to move down.
- `reset_actions()` - Reset all actions to their defaults.
- `reset_action_up()` - Reset the default name of the action to move up.
- `reset_action_down()` - Reset the default name of the action to move down.

### Related components

@TODO

- [`VelocityComponent`](velocity.md) - Description.
- [`ControlsLeftRightComponent`](controls_left_right.md) - Description.
- [`ControlsFourWayComponent`](controls_four_way.md) - Description.
