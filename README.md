# godot4-components

Simple components for Godot 4.

These components are designed to be simple to use, ready to be dropped into a project with minimal configuration, and "smart" or at least sensible defaults.

## Current components

### State Machine

- [`SimpleStateMachine`](doc/SimpleStateMachine.md) - A simple state machine implementation that uses ordinary, specifically-named methods to manage state.

### Stats

- [`StatHealth`](doc/StatHealth.md) - A node for managing a health-like stat.
- [`StatAutoHeal`](doc/StatAutoHeal.md) - A node for enabling timed autohealing for a `StatHealth` node.
- [`Stat`](doc/Stat.md) - A node for managing a generic stat.
- [`StatAutoRecover`](doc/StatAutoRecover.md) - A node for enabling timed autorecovery for a `Stat` node.

### Movement

- [`MovementVelocity`](doc/`MovementVelocity.md) - Controls a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.
- [`MovementControlsLeftRight`](doc/MovementControlsLeftRight.md) - Applies left and right movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsUpDown`](doc/MovementControlsUpDown.md) - Applies up and down movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsFourWay`](doc/MovementControlsFourWay.md) - Applies directional four-way movement to a `MovementVelocity` component.
