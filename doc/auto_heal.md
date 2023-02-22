---
component: AutoHealComponent
class_name: BCAutoHealComponent
---

# <img src="../addons/bc-components/stat/auto_heal.svg" width="48" height="48"> `AutoHealComponent`

Class: `BCAutoHealComponent`

Give a [`HealthComponent`](health.md) the ability to autorecover over time.

## API

### Signals

- `autoheal_counting_down(time_left : float)` - Emitted while autoheal is waiting to start.
- `autoheal_enabled(status : bool)` - Emitted when autoheal is enabled or disabled.
- `autoheal_started()` - Emitted when autoheal starts.
- `autoheal_stopped()` - Emitted when autoheal stops.

### Properties

- `autoheal_amount : float = 0.0` - The amount of autoheal per `autorecover_rate` tick.
- `autoheal_delay : float = 0.0` - The delay before autoheal starts (in seconds).
- `autoheal_rate : float = 0.0` - The rate of autoheal (in seconds).
- `enabled : bool = false` - Whether autoheal is enabled.  Initiates autoheal when enabled.
- `health_node : BCHealthComponent` - The `HealthComponent` to autoheal.

### Methods

- `disable()` - Disable autoheal.
- `enable()` - Enable autoheal.
- `get_delay_time_remaining() -> float` - Return the amount of time left before autoheal commences (in seconds).

### Related components

- [`HealthComponent`](health.md) - Keep track of a health-like numerical statistic (stat).
- [`StatComponent`](stat.md) - Keep track of an arbitrary numerical statistic (stat).
