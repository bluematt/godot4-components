# The components

## State Management

- <img src="../addons/bc-components/state/simple_state_machine.svg" width="20" height="20"> [`SimpleStateMachineComponent`](simple_state_machine.md) - A simple state machine implementation that uses simple specifically-named methods to manage state.

## Stats

- <img src="../addons/bc-components/stat/stat.svg" width="20" height="20"> [`StatComponent`](stat.md) - Keep track of an arbitrary numerical statistic (stat).
	- <img src="../addons/bc-components/stat/auto_recover.svg" width="20" height="20"> [`AutoRecoverComponent`](auto_recover.md) - Give a `StatComponent` the ability to autorecover over time..
- <img src="../addons/bc-components/stat/health.svg" width="20" height="20"> [`HealthComponent`](health.md) - Keep track of a health-like numerical statistic (stat)..
	- <img src="../addons/bc-components/stat/auto_heal.svg" width="20" height="20"> [`AutoHealComponent`](auto_heal.md) - Give a `HealthComponent` the ability to autoheal over time.

## Movement

- <img src="../addons/bc-components/movement/velocity.svg" width="20" height="20"> [`VelocityComponent`](velocity.md) - Control a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.
- <img src="../addons/bc-components/movement/controls_left_right.svg" width="20" height="20"> [`MovementControlsLeftRight`](controls_left_right.md) - Applies left and right movement to a `VelocityComponent`.
- <img src="../addons/bc-components/movement/controls_up_down.svg" width="20" height="20"> [`MovementControlsUpDown`](controls_up_down.md) - Applies up and down movement to a `VelocityComponent`.
- <img src="../addons/bc-components/movement/controls_four_way.svg" width="20" height="20"> [`MovementControlsFourWay`](controls_four_way.md) - Applies directional four-way movement to a `VelocityComponent`.

## Visual

- <img src="../addons/bc-components/visual/placeholder.svg" width="20" height="20"> [`PlaceholderComponent`](placeholder.md) - A visual placeholder component.
- <img src="../addons/bc-components/visual/look_at_cursor.svg" width="20" height="20"> [`LookAtCursorComponent`](look_at_cursor.md) - Rotates a Node2D to "look" at the cursor.
- <img src="../addons/bc-components/visual/look_at_node.svg" width="20" height="20"> [`LookAtNodeComponent`](look_at_node.md) - Rotates a Node2D to "look" at another Node2D.
- <img src="../addons/bc-components/visual/align_to_velocity.svg" width="20" height="20"> [`AlignToVelocityComponent`](align_to_velocity.md) - Align a node to a [`VelocityComponent`](velocity.md) component.

## Effects

- <img src="../addons/bc-components/effect/bounce.svg" width="20" height="20"> [`BounceComponent`](bounce.md) - Add a bouncing effect to a `Node2D`.
- <img src="../addons/bc-components/effect/flash.svg" width="20" height="20"> [`FlashComponent`](flash.md) - Add a flash effect to a `Node2D`.
- <img src="../addons/bc-components/effect/flash.svg" width="20" height="20"> [`FlashOnHitComponent`](flash_on_hit.md) - Add a flash effect to a `Node2D`, triggered by a collision with a [`HurtboxComponent`](hurtbox.md).

## Interactions

- <img src="../addons/bc-components/interact/hitbox.svg" width="20" height="20"> [`HitboxComponent`](hitbox.md) - A simple hitbox component.
- <img src="../addons/bc-components/interact/hurtbox.svg" width="20" height="20"> [`HurtboxComponent`](hurtbox.md) - A simple hurtbox component.

