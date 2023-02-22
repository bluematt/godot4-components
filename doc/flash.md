---
component: FlashComponent
class_name: BCFlashComponent
---

# <img src="../addons/bc-components/effect/flash.svg" width="48" height="48"> `FlashComponent`

Class: `BCFlashComponent`

Add a flash effect to a `Node2D`.

Attach the `FlashComponent` to a `Node2D` to enable a simple flash effect.  Use the component's `flash()` method to trigger the flash.

Internally it uses a `Tween` to control the flash, modulating the `node` between its `default_modulation` color and `flash_modulation` color.

## API

### Signals

- `flashed()` - Emitted when the flash occurs.

### Properties

- `flash_duration: float = 0.2` - The duration of the flash (in seconds).
- `flash_modulation: Color = Color.RED` - The node's flash color modulation.
- `default_modulation: Color = Color.WHITE` - The node's default color modulation.
- `saturation: float = 1.0` - The saturation multiplier for the flash color.
- `target_node: Node2D` - The node to flash.

### Methods

- `flash()`  - Activate the flash effect.

### Related components

[`FlashOnHitComponent`](flash_on_hit.md) - Add a flash effect to a `Node2D`, triggered by a collision of a [`HurtboxComponent`](hurtbox.md) with a [`HitboxComponent`](hitbox.md).
