# <img src="../icons/movement_velocity.svg" width="48" height="48"> `MovementVelocity` component

Controls a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.

## How to use

1. Attach the `MovementVelocity` component to your scene.  It is recommended to add this as a child of the `CharacterBody2D` to control.
2. Select the `CharacterBody2D` node to control in `character_node`.  You can skip this step if the parent is the `CharacterBody2D`.
3. Set the `max_speed`, `acceleration_coefficient` and `deceleration_coefficient` to reflect the movement you prefer.

Setting `acceleration_coefficient` or `deceleration_coefficient` to `1.0` will provide for *instant* acceleration to `max_speed`/deceleration to a stop respectively.

This component works best with the [`MovementControlsLeftRight`](MovementControlsLeftRight.md), [`MovementControlsUpDown`](MovementControlsUpDown.md) and [`MovementControlsFourWay`](MovementControlsFourWay.md) components.
