---
component: VelocityComponent
class_name: BCVelocity
---

# <img src="../addons/bc-components/movement/velocity.svg" width="48" height="48"> `VelocityComponent`

Class: `BCVelocity`

Control a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.

Setting `acceleration_coefficient` or `deceleration_coefficient` to `1.0` will provide *instant* acceleration to `max_speed`/a full stop respectively.

## API

- `character_node : CharacterBody2D` - The `CharacterBody2D` to move.
- `max_speed : float = 64.0` - The maximum speed (pixels per second).
- `acceleration_coefficient : float = 1.0` - The acceleration coefficient ( between `0.0` and `1.0`).  `1.0` is instantaneous (full speed at *t=0*).
- `deceleration_coefficient : float = 1.0` - The acceleration coefficient ( between `0.0` and `1.0`).  `1.0` is instantaneous (full stop at *t=0*).

### Methods

- `get_acceleration() -> float` - Return `acceleration_coefficient`.
- `get_character() -> CharacterBody2D` - Return `character_node`.
- `get_deceleration() -> float` - Return `deceleration_coefficient`.
- `get_direction() -> Vector2` - Return the current direction.
- `get_max_speed() -> float` - Return `max_speed`.
- `set_acceleration(acceleration : float)` - Set `acceleration_coefficient`.
- `set_character(node : CharacterBody2D)` - Set `character_node`.
- `set_deceleration(deceleration : float)` - Set `deceleration_coefficient`.
- `set_direction(direction : Vector2)` - Set the current direction.
- `set_direction_x(x : float)` - Set the current direction's `x` component.
- `set_direction_x_only(x : float)` -  Set the current direction's `x` component, reset the `y` component.
- `set_direction_y(y : float)` - Set the current direction's `y` component.
- `set_direction_y_only(y : float)` - Set the current direction's `y` component, reset the `x` component.
- `set_max_speed(max_speed : float)` - Set `max_speed`.

### Related components

@TODO