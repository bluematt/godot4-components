# StatHealth

A specialised node for managing a health-like stat.

Health can also be set to auto heal over time after damage, after a short delay.

## How to use

1. Attach a node instance of `StatHealth`.
2. Set `max_health`.  Set `autoheal_amount`, `autoheal_rate`, and `autoheal_delay` to enable autohealing.
3. Use `heal`,`heal_fully`, and `damage` methods  to manipulate the health stat, and the various signals to notify listeners when the health stat has changed.

Use the various state methods to determine the current health, and the signals to respond to health changing events.
