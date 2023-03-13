extends BaseComponent
class_name AnimatedComponent

## A base for animated components.

@export_category("AnimatedComponent")

## The smoothing to be applied to the animation.
@export_range(0.0, 1.0) var smoothing := 1.0:
	set(smoothing_):
		smoothing = clampf(smoothing_, 0.0, 1.0)
	get:
		return smoothing
