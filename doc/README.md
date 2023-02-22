# The components

## State Management

- [`SimpleStateMachine`](SimpleStateMachine.md) - A simple state machine implementation that uses ordinary, specifically-named methods to manage state.

## Stats

- [`StatHealth`](StatHealth.md) - Health-like stat component.
- [`StatAutoHeal`](StatAutoHeal.md) - Time-based automatic healing for a  [`StatHealth`](StatHealth.md) component.
- [`StatComponent`](stat.md) - Keep track of an arbitrary numerical statistic (stat).
- [`StatAutoRecover`](StatAutoRecover.md) - Time-based automatic recovery for a  [`Stat`](Stat.md) component.

## Movement

- [`MovementVelocity`](MovementVelocity.md) - Controls a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.
- [`MovementControlsLeftRight`](MovementControlsLeftRight.md) - Applies left and right movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsUpDown`](MovementControlsUpDown.md) - Applies up and down movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsFourWay`](MovementControlsFourWay.md) - Applies directional four-way movement to a [`MovementVelocity`](MovementVelocity.md) component.

## Visual

- [`VisualPlaceholder`](VisualPlaceholder.md) - A visual placeholder component.
- [`VisualLookAtCursor`](VisualLookAtCursor.md) - Rotates a Node2D to "look" at the cursor.
- [`VisualLookAtNode`](VisualLookAtNode.md) - Rotates a Node2D to "look" at another Node2D.
- [`VisualAlignToVelocity`](VisualAlignToVelocity.md) - Align a node to a [`MovementVelocity`](MovementVelocity.md) component.

## Effects

- [`BounceComponent`](bounce.md) - Add a bouncing effect to a `Node2D`.
- [`FlashComponent`](flash.md) - Add a flash effect to a `Node2D`.
- [`FlashOnHitComponent`](flash_on_hit.md) - Add a flash effect to a `Node2D`, triggered by a collision with a [`HurtboxComponent`](hurtbox.md).

## Interactions

- [`InteractHitbox`](InteractHitbox.md) - A simple hitbox component.
- [`InteractHurtbox`](InteractHurtbox.md) - A simple hurtbox component.
