# <img src="../icons/stat.svg" width="48" height="48"> `Stat` component

Generic stat component.

## How to use

1. Attach a node instance of `Stat`.
2. Set `max_stat` to the maximum allowed value for the stat.
3. Use `recover()`, `recover_fully()`, `expend()` and
`exhaust()` methods to manipulate the stat value.

Use the various state methods to determine the current stat, and the
signals to respond to stat changing events.

If you wish to replicate a health-type stat, the [`StatHealth`](StatHealth.md) component may be more suitable.

The [`StatAutoRecover`](StatAutoRecover.md) component can be used to provide time-based autorecovery for this component.
