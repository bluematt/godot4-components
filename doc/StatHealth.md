# StatHealth component

A node for managing a health-like stat.

## How to use

1. Attach a node instance of `StatHealth`.
2. Set `max_health`.
3. Use `heal()`, `heal_fully()`, and `damage()` methods to manipulate the health stat.

Use the various state methods to determine the current health, and the signals to respond to health changing events.
