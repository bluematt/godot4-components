---
component: FlashComponent
class_name: BCFlashComponent
scene: res:///addons/bc-components/effect/flash.tscn
script: res:///addons/bc-components/effect/flash.gd
authors:
  - https://github.com/bluematt/
---

# <img src="../icon.svg" width="48" height="48"> `FlashComponent` 

Class: BCFlashComponent

Add a flash effect to a `Node2D`.

Attach the `FlashComponent` to a `Node2D` to enable a simple flash effect.  Use the component's `flash()` method to trigger the flash.

Internally it uses a `Tween` to control the flash, modulating the `node` between its `default_modulation` color and `flash_modulation` color.

## API

### Signals

- `flashed()` - Emitted when the flash occurs.

### Properties

- `target_node: Node2D` - The node to flash.
- `flash_duration: float = 0.2` - The duration of the flash (in seconds).
- `default_modulation: Color = Color.WHITE` - The node's default color modulation.
- `flash_modulation: Color = Color.RED` - The node's flash color modulation.
- `saturation: float = 1.0` - The saturation multiplier for the flash color.

### Methods

- `flash()`  - Activate the flash effect.
