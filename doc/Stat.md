---
component: StatComponent
class_name: BCStatComponent
scene: res:///addons/bc-components/stat/stat.tscn
script: res:///addons/bc-components/stat/stat.gd
icon: res:///addons/bc-components/stat/stat.svg
authors:
  - https://github.com/bluematt/
---

# <img src="../addons/bc-components/stat/stat.svg" width="48" height="48"> `StatComponent`

Class: `BCStatComponent`

Keep track of an arbitrary numerical statistic (stat).

A `StatComponent`'s value cannot go below zero, nor can it exceed `max_stat`.

## API

### Signals

- `changed(new_value : float)` - Emitted when the stat changes.
- `recovered(amount : float)` - Emitted when the stat is recovered.  Passes in the actual amount of recovery up to `max_stat`.
- `recovered_fully()` - Emitted when fully recovered.
- `expended(amount : float)` - Emitted when the stat is expended.  Passes in the actual amount of expenditure.
- `exhausted()` - Emitted when the stat reaches 0.
- `succeeded()` - Emitted when the stat is expended, and the amount expended was available.
- `failed(deficit : float)` - Emitted when the stat is expended, and the amount expended was not available. Passes in the difference between the amount of stat expended, and the stat available as a deficit.

### Properties

- `max_stat: float` - The maximum allowed stat.

### Methods

- `expend(amount: float) -> bool` - Expend an amount of the stat.  Returns whether there was enough of the stat to consider the expenditure "successful".
- `get_max_stat() -> float` - Get the maximum stat.
- `get_stat() -> float` - Get the stat.
- `is_exhausted() -> bool` - Return whether the stat has been exhausted.
- `is_maxed() -> bool` - Return whether the stat is maxed out.
- `recover(amount : float)` - Recover an amount of the stat.
- `recover_fully()` - Recover the stat to full.
- `set_max_stat(value : float)` - Set the maximum stat.
- `set_stat(value : float)` - Set the stat.

### Related components

The [`HealthComponent`](health.md) may be more suitable for tracking a health-type stat.

The [`StatAutoRecover`](stat_auto_recover.md) component provides time-based autorecovery.
