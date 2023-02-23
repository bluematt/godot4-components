# The components

## State Management

- [`SimpleStateMachine`](SimpleStateMachine.md) - A simple state machine implementation that uses ordinary, specifically-named methods to manage state.

## Stats

- <img src="../addons/bc-components/stat/stat.svg" width="20" height="20"> [`StatComponent`](stat.md) - Keep track of an arbitrary numerical statistic (stat).
- <img src="../addons/bc-components/stat/auto_recover.svg" width="20" height="20"> [`AutoRecoverComponent`](auto_recover.md) - Give a `StatComponent` the ability to autorecover over time..
- <img src="../addons/bc-components/stat/health.svg" width="20" height="20"> [`HealthComponent`](health.md) - Keep track of a health-like numerical statistic (stat)..
- <img src="../addons/bc-components/stat/auto_heal.svg" width="20" height="20"> [`AutoHealComponent`](auto_heal.md) - Give a `HealthComponent` the ability to autoheal over time.

## Movement

- <img src="../addons/bc-components/movement/velocity.svg" width="20" height="20"> [`VelocityComponent`](velocity.md) - Control a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.
- [`MovementControlsLeftRight`](MovementControlsLeftRight.md) - Applies left and right movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsUpDown`](MovementControlsUpDown.md) - Applies up and down movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsFourWay`](MovementControlsFourWay.md) - Applies directional four-way movement to a [`MovementVelocity`](MovementVelocity.md) component.

## Visual

- [`VisualPlaceholder`](VisualPlaceholder.md) - A visual placeholder component.
- [`VisualLookAtCursor`](VisualLookAtCursor.md) - Rotates a Node2D to "look" at the cursor.
- [`VisualLookAtNode`](VisualLookAtNode.md) - Rotates a Node2D to "look" at another Node2D.
- [`VisualAlignToVelocity`](VisualAlignToVelocity.md) - Align a node to a [`MovementVelocity`](MovementVelocity.md) component.

## Effects

- <img src="../addons/bc-components/effect/bounce.svg" width="20" height="20"> [`BounceComponent`](bounce.md) - Add a bouncing effect to a `Node2D`.
- <img src="../addons/bc-components/effect/flash.svg" width="20" height="20"> [`FlashComponent`](flash.md) - Add a flash effect to a `Node2D`.
- <img src="../addons/bc-components/effect/flash.svg" width="20" height="20"> [`FlashOnHitComponent`](flash_on_hit.md) - Add a flash effect to a `Node2D`, triggered by a collision with a [`HurtboxComponent`](hurtbox.md).

## Interactions

- [`InteractHitbox`](InteractHitbox.md) - A simple hitbox component.
- [`InteractHurtbox`](InteractHurtbox.md) - A simple hurtbox component.

