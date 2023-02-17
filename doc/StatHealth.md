# `StatHealth` component

Health-like stat component.

## How to use

1. Attach a node instance of `StatHealth`.
2. Set `max_health` to the maximum allowed health value.
3. Use `heal()`, `heal_fully()`, and `damage()` methods to manipulate the health stat.

Use the various state methods to determine the current health, and the signals to respond to health changing events.

The [`StatAutoHeal`](StatAutoHeal.md) component can be used to provide time-based autohealing for this component.
