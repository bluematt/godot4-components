@icon("res://icons/effect_bounce.svg")
class_name EffectBounce
extends Node

## Allowed looping types.
enum Loop {
	FROM_START, # 
	PING_PONG,
	OFF,
}

## Represents no time at all, in seconds(!).
const __NO_DURATION := 0.0

# The default displacement.
const __DEFAULT_DISPLACEMENT := Vector2.ZERO

# The default duration, in seconds.
const __DEFAULT_DURATION := 1.0

# The default number of repeats.  0 = infinite
const __DEFAULT_REPEATS := 0

## The node to bounce.
@export var node:Node2D

## How long the bounce should take (in seconds).
@export_range(0.0, 1_000_000, 0.01, "hide_slider", "suffix:s") var duration \
	:= __DEFAULT_DURATION

## How far to move the node.
@export var displacement := __DEFAULT_DISPLACEMENT

## The transition type.
@export var transition : Tween.TransitionType = Tween.TRANS_SINE

## The easing type.
@export var easing : Tween.EaseType = Tween.EASE_IN

## How to loop the bounce.
@export var loop:Loop = Loop.FROM_START

## How many times to repeat.  0 means repeat infinitely
@export_range(0, 1_000_000_000) var repeats := __DEFAULT_REPEATS

# The tween which controls the bounce.
@onready var __tween := get_tree().create_tween()

# The original position of the node.
var __original_position:Vector2

# Whether the bounce effect is enabled.
@export var enabled := true:
	set(e):
		enabled = e
		if not enabled: stop()

func _ready() -> void:
	if node == null:
		node = get_parent()
	assert(node, ("No node:Node2D component specified in %s. Select one, or reparent this " +
		"component as a child of a Node2D node.") % [str(get_path())])

	__original_position = node.position

	if enabled:
		play()

## Play the bounce animation.
func play() -> void:
	var target_position := __original_position + displacement
	
	__tween.set_trans(transition)
	__tween.set_loops(repeats)
	__tween.set_ease(easing)

	__tween.tween_property(node, "position", target_position, duration)
	match loop:
		Loop.FROM_START:
			__tween.tween_property(node, "position", __original_position, __NO_DURATION)
		Loop.PING_PONG:
			__tween.tween_property(node, "position", __original_position, duration)
		_:
			pass

## Stop the bounce animation.
func stop() -> void:
	__tween.stop()
	
