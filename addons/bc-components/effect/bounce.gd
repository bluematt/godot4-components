@icon("./bounce.svg")
class_name BCBounceComponent
extends Node

## Add a bouncing effect to a [Node2D].
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/bounce.md

## Emitted when the bounce has started.
signal started()

## Emitted when the bounce has stopped.
signal stopped()

## Looping types.
enum Loop {
	FROM_START, # repeat from the start on a loop
	PING_PONG,  # repeat back and forth
	OFF,        # do not repeat
}

## Represents no time at all, in seconds(!).
const __NO_DURATION := 0.0

## The node to bounce.
@export var target_node:Node2D

## How long the bounce should take (in seconds).
@export_range(0.0, 1_000_000, 0.01, "hide_slider", "suffix:s") var duration \
	:= 1.0

## How far to move the node.
@export var displacement := Vector2.ZERO

## The transition type.
@export var transition : Tween.TransitionType = Tween.TRANS_SINE

## The easing type.
@export var easing : Tween.EaseType = Tween.EASE_IN

## How to loop the bounce.
@export var loop : Loop = Loop.FROM_START

## How many times to repeat.  0 means repeat infinitely.
@export_range(0, 1_000_000_000) var repeats := 0

# The tween which controls the bounce.
@onready var __tween : Tween

# The original position of the node.
var __original_position : Vector2

# Whether the bounce effect is enabled.
@export var enabled := true:
	set(e):
		enabled = e
		if not enabled: stop()

func _ready() -> void:
	if target_node == null:
		target_node = get_parent()
	assert(target_node, ("No target_node:Node2D component specified in %s. " +
		"Select one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])
		
	__tween = get_tree().create_tween()

	__original_position = target_node.position

	if enabled:
		play()

## Play the bounce animation.
func play() -> void:
	var target_position := __original_position + displacement
	
	__tween.set_trans(transition)
	__tween.set_loops(repeats)
	__tween.set_ease(easing)

	started.emit()

	__tween.tween_property(target_node, "position", target_position, duration)
	match loop:
		Loop.FROM_START:
			__tween.tween_property(target_node, "position", __original_position, __NO_DURATION)
		Loop.PING_PONG:
			__tween.tween_property(target_node, "position", __original_position, duration)
		_:
			pass

## Stop the bounce animation.
func stop() -> void:
	__tween.stop()
	stopped.emit()
	
