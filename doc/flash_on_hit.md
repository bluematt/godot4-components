---
component: FlashOnHitComponent
class_name: BCFlashOnHitComponent
---

# <img src="../addons/bc-components/effect/flash.svg" width="48" height="48"> `FlashOnHitComponent` 

Class: `BCFlashOnHitComponent`

Add a flash effect to a `Node2D`, triggered by a collision with a [`HurtboxComponent`](hurtbox.md).

Attach the `FlashOnHitComponent` to a `Node2D` or `HurtboxComponent` to enable a simple flash effect when the `HurtboxComponent` has a suitable collision.  You will need to specify the `target_node` and/or `hurtbox_node` if it is not parented to it, otherwise the component might not work as expected.

Internally it uses a `Tween` to control the flash, modulating the `node` between its `default_modulation` color and `flash_modulation` color.

## API

### Signals

- `flashed()` - Emitted when the flash occurs.

### Properties

- `target_node: Node2D` - The node to flash.
- `hurtbox_node: Node2D` - The `HurtboxComponent` which notifies when to flash.
- `flash_duration: float = 0.2` - The duration of the flash (in seconds).
- `default_modulation: Color = Color.WHITE` - The node's default color modulation.
- `flash_modulation: Color = Color.RED` - The node's flash color modulation.
- `saturation: float = 1.0` - The saturation multiplier for the flash color.

### Methods

- `flash()`  - Activate the flash effect on demand.

### Related components

[`FlashComponent`](flash.md) - Add a flash effect to a `Node2D`.

[`HurtboxComponent`](hurtbox.md).