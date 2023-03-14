@icon("./icon.svg")
extends BaseComponent
class_name AnimatedComponent

## A base for animated components.

@export_category("AnimatedComponent")

## The turning speed factor to be applied to the animation.
@export_range(0.0, 10.0, 0.01, "or_greater") var turning_speed := 5.0
