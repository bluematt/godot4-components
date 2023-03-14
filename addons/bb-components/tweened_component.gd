@icon("./icon.svg")
extends BaseComponent
class_name TweenedComponent

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

## Emitted when the tween has finished.
signal finished()

## Emitted when a tween loop has finished.
signal loop_finished(loop_count: int)

## Emitted when a tween step has finished.
signal step_finished(idx: int)

## The tween's transition type.
@export var transition: Tween.TransitionType = Tween.TRANS_SINE:
	set(transition_):
		transition = transition_
		if _tween:
			_tween.set_trans.call_deferred(transition)

## The tween's easing type.
@export var easing: Tween.EaseType = Tween.EASE_IN:
	set(easing_):
		easing = easing_
		if _tween:
			_tween.set_ease.call_deferred(easing)

## How to loop the tween.
@export var loop: Loop = Loop.FROM_START
	
## How long the tween should take (in seconds).  3,600s is one hour...
@export_range(0.0, 60.0, 0.01, "hide_slider", "suffix:s", "or_greater") var duration := 1.0

## How many times to repeat.  0 means repeat infinitely.
@export_range(0, 1_000, 1, "or_greater") var repeats := 0

# The tween which controls the animation.
@onready var _tween: Tween

## Return the tween.
func get_tween() -> Tween:
	return _tween

# Whether the tween is playing.
var _is_playing := false

## Return whether the animation is playing.
func is_playing() -> bool:
	return _is_playing

func _ready() -> void:
	super()
	
	# Start/stop the tween if the component is enabled/disabled.
	was_enabled.connect(_on_was_enabled)
	was_disabled.connect(_on_was_disabled)
	
	_tween = get_tree().create_tween()
	_tween.pause()

	_tween.set_trans(transition)
	_tween.set_ease(easing)
	_tween.set_loops(repeats)

	# Passthrough signals from the tween.
	_tween.finished.connect(_on_tween_finished)
	_tween.loop_finished.connect(_on_tween_loop_finished)
	_tween.step_finished.connect(_on_tween_step_finished)
	
	define_tween.call_deferred()
	
func start() -> void:
	_is_playing = true
	_tween.play()
	started.emit()

func stop() -> void:
	_is_playing = false
	_tween.pause()
	stopped.emit()

## Define the tween.
func define_tween() -> void:
	assert(false, "define_tween() should be overloaded in the derived class.")

# The method defining the tween's activity.
func _define_tween() -> void:
	define_tween()
	_tween.pause()

func _on_was_enabled() -> void:
	start()

func _on_was_disabled() -> void:
	stop()

func _on_tween_loop_finished(loop_count: int) -> void:
	loop_finished.emit(loop_count)

func _on_tween_step_finished(idx: int) -> void:
	step_finished.emit(idx)

func _on_tween_finished() -> void:
	finished.emit()


