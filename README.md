# Building-Block (BB) Components for Godot 4

Released under the [MIT license](LICENSE).

![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)

A collection of [simple building-block components](doc/README.md) that are designed to be easy to use and be dropped into any Godot 4 project, ready to use with no (or minimal) configuration, and "smart" (or at least sensible) defaults.

These components may be useful for rapid prototyping, quickly testing ideas without requiring major time investment, and for learning (feel free to check out the [lovingly-commented source code](addons/bb-components/)).

While efforts has been made to make the components robust and performant enough for development use, they are not necessarily optimised for production environments. *Caveat consumptor*.  If in doubt, feel free to disassemble and reassemble the components to your own purposes.

# The components

## State Management

- <img src="addons/bb-components/state/simple_state_machine.svg" width="20" height="20"> `SimpleStateMachineComponent` - Manage state with simple named functions.

## Stats

- <img src="addons/bb-components/stat/stat.svg" width="20" height="20"> `StatComponent` - Keep track of an arbitrary numerical statistic (stat).
	- <img src="addons/bb-components/stat/auto_recover.svg" width="20" height="20"> `AutoRecoverComponent` - Give a `StatComponent` the ability to autorecover over time.
- <img src="addons/bb-components/stat/health.svg" width="20" height="20"> `HealthComponent` - Keep track of a health-like numerical statistic (stat).
	- <img src="addons/bb-components/stat/auto_heal.svg" width="20" height="20"> `AutoHealComponent` - Give a `HealthComponent` the ability to autoheal over time.

## Movement

- <img src="addons/bb-components/movement/velocity.svg" width="20" height="20"> `VelocityComponent` - Apply acceleration and deceleration to `CharacterBody2D.velocity`.
- <img src="addons/bb-components/movement/controls_left_right.svg" width="20" height="20"> `ControlsLeftRight` - Apply left/right movement to a `VelocityComponent`.
- <img src="addons/bb-components/movement/controls_up_down.svg" width="20" height="20"> `MovementControlsUpDown` - Apply up/down movement to a `VelocityComponent`.
- <img src="addons/bb-components/movement/controls_four_way.svg" width="20" height="20"> `MovementControlsFourWay` - Apply four-way movement to a `VelocityComponent`.

## Visual

- <img src="addons/bb-components/visual/placeholder.svg" width="20" height="20"> `PlaceholderComponent` - A visual placeholder component.
- <img src="addons/bb-components/visual/look_at_cursor.svg" width="20" height="20"> `LookAtCursorComponent` - Rotate a `Node2D` to "look" at the cursor.
- <img src="addons/bb-components/visual/look_at_node.svg" width="20" height="20"> `LookAtNodeComponent` - Rotate a `Node2D` to "look" at another `Node2D`.
- <img src="addons/bb-components/visual/align_to_velocity.svg" width="20" height="20"> `AlignToVelocityComponent` - Align a `Node2D`'s rotation to follow a `VelocityComponent`.
## Effects

- <img src="addons/bb-components/effect/bounce.svg" width="20" height="20"> `BounceComponent` - Add a simple bouncing effect to a `Node2D`.
- <img src="addons/bb-components/effect/flash.svg" width="20" height="20"> `FlashComponent` - Add a triggerable flash effect to a `Node2D`.
- <img src="addons/bb-components/effect/flash.svg" width="20" height="20"> `FlashOnHitComponent` - Add a `FlashComponent` effect to a `Node2D`, triggered by a collision between a `HitboxComponent` and a `HurtboxComponent`.

## Interactions

- <img src="addons/bb-components/interact/hitbox.svg" width="20" height="20"> `HitboxComponent` - Inflict damage on a `HurtboxComponent`.
- <img src="addons/bb-components/interact/hurtbox.svg" width="20" height="20"> `HurtboxComponent` - Receive damage from a `HitboxComponent`.
