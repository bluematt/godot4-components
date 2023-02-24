---
component: PlaceholderComponent
class_name: BCPlaceholder
---

# <img src="../addons/bc-components/visual/placeholder.svg" width="48" height="48"> `PlaceholderComponent` 

Class: `BCPlaceholder`

A visual placeholder component.

Attach a `PlaceholderComponent` where you want to display a visual element, but don't yet have the relevant assets.  Supports colour fills, text labels as well as placeholder textures.

Default `dimension` is 64&times;64 pixels, minimum `dimension` is 2&times;2 pixels.

Background fill colours do not support alpha tranparency.  If you want to have a (semi)transparent `PlaceholderComponent`, adjust the component's `modulate`/`self_modulate` properties.

Labels are constrained to the space available, with a minimum width of 64 pixels and maximum of two lines of text.  Text is always aligned to the centre of the placeholder.

Textures that are not the same size as the `PlaceholderComponent` will be stretched to fill `dimension`.

## API

### Signals

- `dimensions_changed(new_dimensions : Vector2)` - Emitted when the dimensions have changed.
- `color_changed(new_color : Color)` - Emitted when the background colour has changed.
- `texture_changed(new_texture : Texture)` - Emitted when the texture has changed.
- `label_changed(new_label : String)` - Emitted when the label has changed.

### Properties

- `dimensions : Vector2 = Vector2(64.0, 64.0)` - The dimensions of the placeholder.
- `color : Color = Color.SLATE_GRAY` - The background colour.
- `texture : Texture` - The texture to display.  The texture will stretch to fill the placeholder dimensions.
- `label_text : String = ""` - The label to display.
- `label_size : int = 16` - The label text size.

### Methods

- `method(var : Type) -> Type` - Description.

### Related components

- [`RelatedComponent`](related.md) - Description.



# <img src="../icons/visual_placeholder.svg" width="48" height="48"> `VisualPlaceholder` component

A visual placeholder component.

For use as a temporary representation of a visual element.

## How to use

1. Drop a `VisualPlaceholder` component into your scene.
2. Update the `dimensions`, `color`, `texture` and/or `label` properties to your needs.
