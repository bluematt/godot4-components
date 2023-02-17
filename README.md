# Simple components for Godot 4

![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)

These components are designed to be simple to use, ready to be dropped into a Godot 4 project with minimal configuration, and "smart" or at least sensible defaults.

## Current components

### State Machine

- [`SimpleStateMachine`](doc/SimpleStateMachine.md) - A simple state machine implementation that uses ordinary, specifically-named methods to manage state.

### Stats

- [`StatHealth`](doc/StatHealth.md) - Health-like stat component.
- [`StatAutoHeal`](doc/StatAutoHeal.md) - Time-based automatic healing for a  [`StatHealth`](StatHealth.md) component.
- [`Stat`](doc/Stat.md) - Generic stat component.
- [`StatAutoRecover`](doc/StatAutoRecover.md) - Time-based automatic recovery for a  [`Stat`](Stat.md) component.

### Movement

- [`MovementVelocity`](doc/MovementVelocity.md) - Controls a `CharacterBody2D` node, applying a maximum speed with acceleration and deceleration coefficients.
- [`MovementControlsLeftRight`](doc/MovementControlsLeftRight.md) - Applies left and right movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsUpDown`](doc/MovementControlsUpDown.md) - Applies up and down movement to a [`MovementVelocity`](MovementVelocity.md) component.
- [`MovementControlsFourWay`](doc/MovementControlsFourWay.md) - Applies directional four-way movement to a [`MovementVelocity`](doc/MovementVelocity.md) component.
