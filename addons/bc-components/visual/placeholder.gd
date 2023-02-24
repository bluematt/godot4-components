@tool
@icon("./placeholder.svg")
class_name BCPlaceholder
extends Node2D

## A visual placeholder component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/placeholder.md

# The minimum width taken up by a label.
const __MINIMUM_LABEL_WIDTH := 64.0 # pixels

# Represents a half factor used for calculations.
const __HALF_FACTOR := 0.5

# The luminance threshold used to determine contrast.
const __LUMINANCE_THRESHOLD := 0.5

# The colour of the label text.
const __LABEL_COLOR_TEXT := Color.WHITE

# The colour of the label text outline.
const __LABEL_COLOR_OUTLINE := Color.BLACK

# The maximum number of lines in the label.
const __LABEL_LINES_MAX := 2

# The thickness of the label outline.
const __LABEL_WIDTH_OUTLINE := 4

## Emitted when the dimensions have changed.
signal dimensions_changed(new_dimensions : Vector2)

## Emitted when the background color has changed.
signal color_changed(new_color : Color)

## Emitted when the texture has changed.
signal texture_changed(new_texture : Texture)

## Emitted when the label has changed.
signal label_changed(new_label : String)

@export_category("PlaceholderComponent")

## The dimensions of the placeholder.
@export var dimensions := Vector2(64.0, 64.0):
	set(s):
		dimensions = s
		queue_redraw()
		dimensions_changed.emit(dimensions)

## The background colour.
@export_color_no_alpha var color := Color.SLATE_GRAY:
	set(c):
		color = c
		queue_redraw()
		color_changed.emit(color)

## The texture to display.  The texture will stretch to fill the placeholder
## dimensions.
@export var texture:Texture:
	set(t):
		texture = t
		queue_redraw()
		texture_changed.emit(texture)
		
@export_group("Label", "label_")

## The label to display.
@export_placeholder("e.g. player 1") var label_text := "":
	set(t):
		label_text = t
		queue_redraw()
		label_changed.emit(label_text)

## The label text size.
@export_range(8, 32, 1) var label_size := 16:
	set(s):
		label_size = clamp(s, 8, 32)
		queue_redraw()
		label_changed.emit(label_text)

func _draw() -> void:
	## Determine the size of the placeholder.
	var bounds_rect := Rect2(dimensions * (-__HALF_FACTOR), dimensions)

	# Draw the coloured rectangle.
	draw_rect(bounds_rect, color, true)

	# If there is no texture and no label, draw a simple contrasting
	# cross design to highlight that this is a placeholder, not a simple
	# coloured rectangle.
	if texture == null and label_text == "":
		# Determine a contasting colour.
		var line_color := Color.WHITE
		if color.get_luminance() > __LUMINANCE_THRESHOLD:
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
		var text_width := maxf(__MINIMUM_LABEL_WIDTH, bounds_rect.size.x)
		var text_pos := Vector2.ZERO
		text_pos.x -= text_width * __HALF_FACTOR
		text_pos.y += default_font.get_ascent(font_size) * __HALF_FACTOR - \
			default_font.get_descent(font_size) * __HALF_FACTOR
		
		draw_multiline_string_outline(default_font, text_pos, label_text, 
			HORIZONTAL_ALIGNMENT_CENTER, text_width, font_size, 
			__LABEL_LINES_MAX, __LABEL_WIDTH_OUTLINE, __LABEL_COLOR_OUTLINE)
		draw_multiline_string(default_font, text_pos, label_text, 
			HORIZONTAL_ALIGNMENT_CENTER, text_width, font_size, 
			__LABEL_LINES_MAX, __LABEL_COLOR_TEXT)

func set_dimensions(new_dimensions : Vector2) -> void:
	if new_dimensions.x < 2: new_dimensions.x = 2
	if new_dimensions.y < 2: new_dimensions.y = 2
	dimensions = new_dimensions

func get_dimensions() -> Vector2:
	return dimensions

func set_color(new_color: Color) -> void:
	color = new_color
	
func get_color() -> Color:
	return color

func set_texture(new_texture : Texture) -> void:
	texture = new_texture
	
func get_texture() -> Texture:
	return texture
	
func clear_texture() -> void:
	texture = null
	
func set_label(new_text : String, new_size : int) -> void:
	set_label_text(new_text)
	set_label_size(new_size)

func set_label_text(new_text : String) -> void:
	label_text = new_text

func set_label_size(new_size : int) -> void:
	label_size = new_size

func clear_label() -> void:
	set_label_text("")
