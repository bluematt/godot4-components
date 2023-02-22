---
component: StatAutoRecoverComponent
class_name: BCStatAutoRecoverComponent
---

# <img src="../addons/bc-components/stat/stat_auto_recover.svg" width="48" height="48"> `StatAutoRecoverComponent`

Class: `BCStatAutoRecoverComponent`

Give a [`StatComponent`](stat.md) the ability to autorecover over time.

## API

### Signals

- `autorecovery_counting_down(time_left : float)` - Emitted while autorecovery is waiting to start.
- `autorecovery_enabled(status : bool)` - Emitted when autorecovery is enabled or disabled.
- `autorecovery_started()` - Emitted when autorecovery starts.
- `autorecovery_stopped()` - Emitted when autorecovery stops.

### Properties

- `autorecover_amount : float = 0.0` - The amount of autorecovery per `autorecover_rate` tick.
- `autorecover_delay : float = 0.0` - The delay before autorecovery starts (in seconds).
- `autorecover_rate : float = 0.0` - The rate of autorecovery (in seconds).
- `enabled : bool = false` - Whether autorecovery is enabled.  Initiates autorecovery when enabled.
- `stat_node : BCStatComponent` - The `StatComponent` to autorecover.

### Methods

- `disable()` - Disable autorecovery.
- `enable()` - Enable autorecovery.
- `get_delay_time_remaining() -> float` - Return the amount of time left before autohealing commences (in seconds).

### Related components

- [`StatComponent`](stat.md) - Keep track of an arbitrary numerical statistic (stat).
