@tool
@icon("./placeholder_component.svg")
extends Node2D
class_name PlaceholderComponent

## A visual placeholder component.

# The minimum width taken up by a label.
const MINIMUM_LABEL_WIDTH := 64.0 # pixels

# Represents a half factor used for calculations.
const _HALF_FACTOR := 0.5

# The luminance threshold used to determine contrast.
const LUMINANCE_THRESHOLD := 0.5

# The colour of the label text.
const LABEL_COLOR_TEXT := Color.WHITE

# The colour of the label text outline.
const LABEL_COLOR_OUTLINE := Color.BLACK

# The maximum number of lines in the label.
const LABEL_LINES_MAX := 2

# The thickness of the label outline.
const LABEL_WIDTH_OUTLINE := 4

## Emitted when the dimensions have changed.
signal dimensions_changed(dimensions: Vector2)

## Emitted when the background color has changed.
signal color_changed(color: Color)

## Emitted when the texture has changed.
signal texture_changed(texture: Texture)

## Emitted when the label has changed.
signal label_changed(label: String)

@export_category("PlaceholderComponent")

## The dimensions of the placeholder.
@export var dimensions := Vector2(64.0, 64.0):
	set(dimensions_):
		if dimensions_.x < 2: dimensions_.x = 2
		if dimensions_.y < 2: dimensions_.y = 2
		dimensions = dimensions_
		queue_redraw()
		dimensions_changed.emit(dimensions)

## The background colour.
@export var color := Color.SLATE_GRAY:
	set(color_):
		color = color_
		queue_redraw()
		color_changed.emit(color)

## The texture to display.  The texture will stretch to fill the placeholder
## dimensions.
@export var texture:Texture:
	set(texture_):
		texture = texture_
		queue_redraw()
		texture_changed.emit(texture)

@export_group("Label", "label_")

## The label to display.
@export_placeholder("e.g. player 1") var label_text := "":
	set(label_text_):
		label_text = label_text_
		queue_redraw()
		label_changed.emit(label_text)

## The label text size.
@export_range(8, 32, 1) var label_size := 16:
	set(label_size_):
		label_size = clampi(label_size_, 8, 32)
		queue_redraw()

func _draw() -> void:
	## Determine the size of the placeholder.
	var bounds_rect := Rect2(dimensions * (-_HALF_FACTOR), dimensions)

	# Draw the coloured rectangle.
	draw_rect(bounds_rect, color, true)

	# If there is no texture and no label, draw a simple contrasting
	# cross design to highlight that this is a placeholder, not a simple
	# coloured rectangle.
	if null == texture and "" == label_text:
		# Determine a contasting colour.
		var line_color := Color.WHITE
		if color.get_luminance() > LUMINANCE_THRESHOLD:
			line_color = Color.BLACK
		# Draw the cross motif.
		draw_line(bounds_rect.position, bounds_rect.end, line_color)
		draw_line(Vector2(bounds_rect.position.x, bounds_rect.end.y), 
			Vector2(bounds_rect.end.x, bounds_rect.position.y), line_color)

	# Draw the texture, if it exists.
	if texture:
		draw_texture_rect(texture, bounds_rect, false)

	# Draw the label, if it exists.
	if label_text:
		# Use the project's default font.
		var default_font = ThemeDB.fallback_font
		var font_size := ThemeDB.fallback_font_size
		if label_size:
			font_size = label_size
		var text_width := maxf(MINIMUM_LABEL_WIDTH, bounds_rect.size.x)
		var text_pos := Vector2.ZERO
		text_pos.x -= text_width * _HALF_FACTOR
		text_pos.y += default_font.get_ascent(font_size) * _HALF_FACTOR - \
			default_font.get_descent(font_size) * _HALF_FACTOR
		
		draw_multiline_string_outline(default_font, text_pos, label_text, 
			HORIZONTAL_ALIGNMENT_CENTER, text_width, font_size, 
			LABEL_LINES_MAX, LABEL_WIDTH_OUTLINE, LABEL_COLOR_OUTLINE)
		draw_multiline_string(default_font, text_pos, label_text, 
			HORIZONTAL_ALIGNMENT_CENTER, text_width, font_size, 
			LABEL_LINES_MAX, LABEL_COLOR_TEXT)


## Clear the current texture.
func clear_texture() -> void:
	texture = null

## Clear the current label.
func clear_label() -> void:
	label_text = ""
	label_size = 16

## Clear the current color.
func clear_color() -> void:
	color = Color.SLATE_GRAY

