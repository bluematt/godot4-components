# <img src="../icons/movement_controls_four_way.svg" width="48" height="48"> `MovementControlsFourWay` component

Applies directional four-way movement to a `MovementVelocity` component.

## How to use

1. Attach the `MovementControlsFourWay` component to your scene.  It is recommended to add this as a child of the `MovementVelocity` to control.
2. Select the `MovementVelocity` node to control in `velocity_node`.  You can skip this step if the parent is the `MovementVelocity`.
3. Create new (or import existing) `InputEventAction` resources for `input_action_up`, `input_action_down`, `input_action_left` and `input_action_right`.  Set the relevant `action` for each to the input actions you wish to use.  These input actions should already be defined in Project Settings.

If no `InputEventAction`s are specified for `input_action_up`, `input_action_down`, `input_action_left` and/or `input_action_right`, they will default to using the built-in `ui_up`/`ui_down`/`ui_left`/`ui_right` input actions respectively.

If one dimensional movement is needed, [`MovementControlsLeftRight`](MovementControlsLeftRight.md) and [`MovementControlsUpDown`](MovementControlsUpDown.md) provide for horizontal and vertical movement respectively.
