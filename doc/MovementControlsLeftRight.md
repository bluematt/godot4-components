# `MovementControlsLeftRight` component

Applies left and right movement to a [`MovementVelocity`](MovementVelocity.md) component.

## How to use

1. Attach the `MovementControlsLeftRight` component to your scene.  It is recommended to add this as a child of the `MovementVelocity` to control.
2. Select the `MovementVelocity` node to control in `velocity_node`.  You can skip this step if the parent is the `MovementVelocity`.
3. Create new (or import existing) `InputEventAction` resources for `input_action_left` and `input_action_right`.  Set the relevant `action` for each to the input actions you wish to use.  These input actions should already be defined in Project Settings.

If no `InputEventAction`s are specified for `input_action_left` and/or `input_action_right`, they will default to using the built-in `ui_left` and `ui_right` input actions respectively.

This component can be combined with [`MovementControlsUpDown`](MovementControlsUpDown.md) to provide four-way movement.  Four-way movement is also provided for by [`MovementControlsFourWay`](MovementControlsFourWay.md).
