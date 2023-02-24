---
component: HealthComponent
class_name: BBHealth
---

# <img src="../addons/bc-components/stat/health.svg" width="48" height="48"> `HealthComponent`

Class: `BBHealth`

Keep track of a health-like numerical statistic (stat).

A `HealthComponent`'s value cannot go below zero, nor can it exceed `max_health`.

## API

### Signals

- `changed(new_value : float)` - Emitted when health changes.
- `healed(amount : float)` - Emitted when healing takes place.  Passes in the actual amount of healing up `max_health`.
- `healed_fully()` - Emitted when fully healed.
- `damaged(amount : float)` - Emitted when damage takes place.  Passes in the actual amount of damage.
- `died()` - Emitted when health reaches 0.
- `revived()` - Emitted when health has been restored after death.

### Properties

- `max_health: float` - The maximum allowed health.

### Methods

- `damage(amount : float)` - Apply an amount of damage.
- `get_health() -> float` - Return the current health.
- `get_max_health() -> float` - Return the maximum health.
- `heal(amount : float, will_revive : bool = false)` - Apply an amount of healing.  If `will_revive` is true, the health can be from a "dead" state.
- `heal_fully()` - Apply a full amount of healing.
- `is_alive() -> bool` - Return whether the health should be considered "alive".
- `is_dead() -> bool` - Return whether the health should be considered "dead".
- `is_maxed() -> bool` - Return whether the health is maxed out.
- `revive(amount : float)` - Revive the health from "dead" state. If `is_alive()` returns true, this method does nothing.
- `set_max_health(value : float)` - Set the maximum health.
- `set_health(value : float)` - Set the health.

### Related components

- [`StatComponent`](stat.md) - Keep track of an arbitrary numerical statistic (stat).
- [`AutoHealComponent`](auto_heal.md) - Give a `HealthComponent` the ability to autoheal over time.

 
