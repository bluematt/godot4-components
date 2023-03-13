extends "res://addons/bb-components/base_component.gd"

## Looping types.
enum Loop {
	FROM_START, # repeat from the start on a loop
	PING_PONG,  # repeat back and forth
	OFF,        # do not repeat
}

## Represents no time at all, in seconds(!).
const NO_DURATION := 0.0

## Emitted when the tween has started.
signal started()

## Emitted when the tween has stopped.
signal stopped()

signal finished()
signal loop_finished(loop_count: int)
signal step_finished(idx: int)

@export_category("TweenedComponent")

## The tween's transition type.
@export var transition : Tween.TransitionType = Tween.TRANS_SINE:
	set=set_transition, get=get_transition

## Set [member transition].
func set_transition(_transition : Tween.TransitionType) -> void:
	transition = _transition
	if __tween: __tween.set_trans.call_deferred(transition)

## Get [member transition].
func get_transition() -> Tween.TransitionType: return transition

## The tween's easing type.
@export var easing : Tween.EaseType = Tween.EASE_IN:
	set=set_easing, get=get_easing

## Set [member easing].
func set_easing(_easing : Tween.EaseType) -> void:
	easing = _easing
	if __tween: __tween.set_ease.call_deferred(easing)

## Get [member easing].
func get_easing() -> Tween.EaseType: return easing

## How to loop the tween.
@export var loop : Loop = Loop.FROM_START:
	set=set_loop, get=get_loop
	
## Set [member loop].
func set_loop(_loop : Loop) -> void: loop = _loop

## Get [member loop].
func get_loop() -> Loop: return loop

## How long the tween should take (in seconds).  3,600s is one hour...
@export_range(0.0, 3_600, 0.01, "hide_slider", "suffix:s") var duration := 1.0:
	set=set_duration, get=get_duration

## Set the duration of the tween.
func set_duration(_duration : float) -> void: duration = max(0, _duration)

## Get the duration of the tween.
func get_duration() -> float: return duration
		
## How many times to repeat.  0 means repeat infinitely.
@export_range(0, 1_000_000_000) var repeats := 0:
	set=set_repeats, get=get_repeats

## Set repeat count.
func set_repeats(_repeats : int) -> void:
	repeats = max(0, _repeats)
	if __tween: __tween.set_loops.call_deferred(repeats)

## Get repeat count.
func get_repeats() -> int: return repeats

# The tween which controls the animation.
@onready var __tween : Tween

## Return the tween.
func get_tween() -> Tween: return __tween

# Whether the tween is playing.
var __is_playing := false

## Return whether the animation is playing.
func is_playing() -> bool:
	return __is_playing

func _ready() -> void:
	super()
	
	# Start/stop the tween if the component is enabled/disabled.
	was_enabled.connect(func(): start())
	was_disabled.connect(func(): stop())
	
	__tween = get_tree().create_tween()
	__tween.pause()

	__tween.set_trans(transition)
	__tween.set_ease(easing)
	__tween.set_loops(repeats)

	# Passthrough signals from the tween.
	__tween.finished.connect(__on_tween_finished)
	__tween.loop_finished.connect(__on_tween_loop_finished)
	__tween.step_finished.connect(__on_tween_step_finished)
	
	define_tween.call_deferred()

func __on_tween_finished() -> void:
	finished.emit()

func __on_tween_loop_finished(loop_count: int) -> void:
	loop_finished.emit(loop_count)

func __on_tween_step_finished(idx: int) -> void:
	step_finished.emit(idx)

func start() -> void:
	__is_playing = true
	__tween.play()
	started.emit()

func stop() -> void:
	__is_playing = false
	__tween.pause()
	stopped.emit()

# The method defining the tween's activity.
func _define_tween() -> void:
	define_tween()
	__tween.pause()

func define_tween() -> void:
	assert(false, "define_tween() should be overloaded in the derived class.")
