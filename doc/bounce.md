---
component: BounceComponent
class_name: BCBounceComponent
scene: res:///addons/bc-components/effect/bounce.tscn
script: res:///addons/bc-components/effect/bounce.gd
icon: res:///addons/bc-components/effect/bounce.svg
authors:
  - https://github.com/bluematt/
---

# <img src="../addons/bc-components/effect/bounce.svg" width="48" height="48"> `BounceComponent` 

Class: `BCBounceComponent`

Add a bouncing effect to a `Node2D`.

Attach the `BCBounceComponent` to a `Node2D` to enable a simple bouncing mechanic.

Internally it uses a `Tween` to control the bounce mechanic, moving the `node` between its original position and the position described by the `displacement` from the original position.

Note: In `Loop.PING_PONG` mode, the `duration` refers to movement in one direction only.  The return movement will also take `duration` seconds.

## API

### Constants

None.

### Enumerations

- `Loop { FROM_START, PING_PONG, OFF }` 
  Looping types.

### Signals

- `started()`
	Emitted when the bounce has started.
- `stopped()`
	Emitted when the bounce has stopped.

### Properties

- `node: Node2D` †
	The node to bounce.
- `duration: float = 1.0`
	How long the bounce should take (in seconds).
- `displacement: Vector2 = Vector2.ZERO`
	How far to move the node.
- `transition: Tween.TransitionType = Tween.TRANS_SINE`
	The transition type.
- `easing: Tween.EaseType = Tween.EASE_IN`
	The easing type.
- `loop: Loop { FROM_START, PING_PONG, OFF } = Loop.FROM_START`
	How to loop the bounce.
- `repeats: int = 0`
	How many times to repeat.  0 means repeat infinitely.
- `enabled: bool = true`
	Whether the bounce effect is enabled.

### Method

- `play()` 
	Play the bounce animation.
- `stop()` 
	Stop the bounce animation.

## Notes
† Required.
