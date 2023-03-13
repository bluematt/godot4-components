@icon("./velocity.svg")
class_name VelocityComponent
extends Node

## Apply acceleration and deceleration to [member CharacterBody2D.velocity].

## The target velocity when decelerating.
const DECELERATION_TARGET_VELOCITY := Vector2.ZERO

## The maximum speed (pixels per second).
@export var max_speed := 64.0:
	set(max_speed_):
		max_speed = max(0.0, max_speed_)

## The deceleration coefficient (0.0-1.0).  1.0 is instantaneous (full speed at
## [i]t=0[/i]).
@export_range(0.0, 1.0) var acceleration_coefficient := 1.0:
	set(acceleration_coefficient_):
		acceleration_coefficient = clampf(acceleration_coefficient_, 0.0, 1.0)

@export_range(0.0, 1.0) var deceleration_coefficient := 1.0:
	set(deceleration_coefficient_):
		deceleration_coefficient = clampf(deceleration_coefficient_, 0.0, 1.0)

# The [CharacterBody2D] to move.
var _character_node:CharacterBody2D

## The direction of the velocity.
var direction := Vector2.ZERO

func _ready() -> void:
	_character_node = get_parent() as CharacterBody2D
	assert(_character_node, "VelocityComponent must be a child of a CharacterBody2D node in %s." % [str(get_path())])

func _physics_process(_delta : float) -> void:
	# Accelerate if we have somewhere to go.
	if direction: # bool(Vector2.ZERO) == false
		__accelerate()
	else:
		# Decelerate if we're still moving.
		if _character_node.velocity:
			__decelerate()

	_character_node.move_and_slide()

# Accelerate the [member character_node].
func __accelerate() -> void:
	var acceleration_rate := max_speed * acceleration_coefficient
	var speed = direction.normalized() * max_speed
	_character_node.velocity = _character_node.velocity.move_toward(speed, acceleration_rate)

# Decelerate the [member character_node].
func __decelerate() -> void:
	var deceleration_rate := max_speed * deceleration_coefficient
	_character_node.velocity = _character_node.velocity.move_toward(DECELERATION_TARGET_VELOCITY, deceleration_rate)
