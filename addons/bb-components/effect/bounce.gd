@icon("./bounce.svg")
class_name BBBounce
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
@export var target_node : Node2D

## How long the bounce should take (in seconds).
@export_range(0.0, 1_000_000, 0.01, "hide_slider", "suffix:s") var duration \
	:= 1.0:
	set(d):
		duration = max(0, d)

## How far to move the node from its original position (in pixels).
@export var displacement := Vector2.ZERO

## The transition type.
@export var transition : Tween.TransitionType = Tween.TRANS_SINE

## The easing type.
@export var easing : Tween.EaseType = Tween.EASE_IN

## How to loop the bounce.
@export var loop : Loop = Loop.FROM_START

## How many times to repeat.  0 means repeat infinitely.
@export_range(0, 1_000_000_000) var repeats := 0:
	set(r):
		repeats = max(0, r)

# The tween which controls the bounce.
@onready var __tween : Tween

# The original position of the node.
var __original_position : Vector2

var __is_playing := false

# Whether the bounce effect is enabled.
@export var enabled := true:
	set(e):
		enabled = e
		if not enabled: stop()

func _ready() -> void:
	if null == target_node:
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
	__is_playing = true
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
	__is_playing = false
	__tween.stop()
	stopped.emit()

## Set the target node.
func set_target(new_target : Node2D) -> void:
	target_node = new_target

## Get the target node.
func get_target() -> Node2D:
	return target_node

## Set the duration of the animation.
func set_duration(time : float) -> void:
	duration = time

## Get the duration of the animation.
func get_duration() -> float:
	return duration

## Set the displacement.
func set_displacement(distance : Vector2) -> void:
	displacement = distance

## Get the displacement.
func get_displacement() -> Vector2:
	return displacement

## Set the transition.
func set_transition(new_transition : Tween.TransitionType) -> void:
	transition = new_transition

## Get the transition.
func get_transition() -> Tween.TransitionType:
	return transition

## Set the easing.
func set_easing(new_easing : Tween.EaseType) -> void:
	easing = new_easing

## Get the easing.
func get_easing() -> Tween.EaseType:
	return easing

## Set the loop setting.
func set_loop(new_loop : Loop) -> void:
	loop = new_loop

## Get the loop setting.
func get_loop() -> Loop:
	return loop

## Set repeat count.
func set_repeats(new_repeats : int) -> void:
	repeats = new_repeats

## Get repeat count.
func get_repeats() -> int:
	return repeats

## Enable (and start) the bounce animation.
func enable() -> void:
	enabled = true

## Disable (and stop) the bounce animation.
func disable() -> void:
	enabled = false

## Set the enabled flag.
func set_enabled(enable : bool) -> void:
	enabled = enable

## Get the enabled flag.
func get_enabled() -> bool:
	return enabled

## Return whether the bounce animation is enabled.
func is_enabled() -> bool:
	return enabled

## Return whether the animation is playing.
func is_playing() -> bool:
	return __is_playing
