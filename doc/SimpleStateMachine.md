# SimpleStateMachine component

A simple state machine implementation that uses ordinary, specifically-named methods to manage state.

## How to use

1. Create a `Node`, attach a script, and extend from `SimpleStateMachine`.
2. Create methods in your script to handle the game loop and events.  For example, to manage the state "`idle`", define methods such as:

```gdscript
extends SimpleStateMachine

func idle_process(delta): ...
func idle_physics_process(delta): ...
func idle_unhandled_input(event): ...
# # and so on.
```

The game loop events that are handled are `Node._process`, ` Node._physics_process`, `Node._input`, `Node._shortcut_input`,`Node._unhandled_input` and `Node._unhandled_key_input`.

**Note:** Only names that would result in valid identifiers are allowed as state names.

You do not need to define methods to handle all of these. Any that do not exist are simply ignored.  You can see what methods are called by setting the `debug` option to`true`.

## Transitioning between states

To transition to another state, use `transition_to`.  You do not need to prepend the `method_prefix` if you have specified one (see below).

Two special methods can also be defined which are called when transitioning from one state to another:`<state>_enter()` and`<state>_exit()`.

```gdscript
func idle_exit(): ...
func idle_enter(): ...
```

These are activated once per transition, if they are defined.

The `method_prefix` property allows you to "namespace" your state-related methods. If you set `method_prefix`, you will need to name all of your methods appropriately, e.g. using the prefix "`my_prefix_`":

```gdscript
func my_prefix_idle_enter(): ...
func my_prefix_idle_process(delta): ...
func my_prefix_idle_unhandled_input(delta): ...
func my_prefix_idle_exit(): ...
# # and so on.
```

Finally, don't forget to set the `initial_state`!
