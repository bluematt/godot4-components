# Stat

A generic stat component.

## How to use

1. Attach a node instance of `Stat`.
2. Set `max_stat`.
3. Use `recover(]`, `recover_fully(]`, `expend()` and
`exhaust()` methods to manipulate the stat.

Use the various state methods to determine the current stat, and the
signals to respond to stat changing events.

If you wish to replicate a health-type stat, the `StatHealth` component may
be more suitable.
