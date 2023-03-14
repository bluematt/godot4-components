@icon("./velocity_component.svg")
class_name VelocityComponent
extends Node

## Apply acceleration and deceleration to [member CharacterBody2D.velocity].

## The target velocity when decelerating.
const DECELERATION_TARGET_VELOCITY := Vector2.ZERO

## The maximum speed (pixels per second).
@export_range(0.0, 1000.0, 0.01, "or_greater", "hide_slider") var max_speed := 64.0

## The acceleration coefficient (0.0-1.0).  1.0 is instantaneous (full speed at
## [i]t=0[/i]).
@export_range(0.0, 1.0) var acceleration_coefficient := 1.0

## The deceleration coefficient (0.0-1.0).  1.0 is instantaneous (full speed at
## [i]t=0[/i]).
@export_range(0.0, 1.0) var deceleration_coefficient := 1.0

## The direction of the velocity.
var direction := Vector2.ZERO

## The [CharacterBody2D] to move.
var character_node:CharacterBody2D

func _ready() -> void:
	character_node = get_parent() as CharacterBody2D
	assert(character_node, "VelocityComponent must be a child of a CharacterBody2D node in %s." % [str(get_path())])

func _physics_process(_delta: float) -> void:
	# Accelerate if we have somewhere to go.
	if direction: # bool(Vector2.ZERO) == false
		_accelerate()
	else:
		# Decelerate if we're still moving.
		if character_node.velocity:
			_decelerate()

	character_node.move_and_slide()

# Accelerate the [member character_node].
func _accelerate() -> void:
	var acceleration_rate := max_speed * acceleration_coefficient
	var speed = direction.normalized() * max_speed
	character_node.velocity = character_node.velocity.move_toward(speed, acceleration_rate)

# Decelerate the [member character_node].
func _decelerate() -> void:
	var deceleration_rate := max_speed * deceleration_coefficient
	character_node.velocity = character_node.velocity.move_toward(DECELERATION_TARGET_VELOCITY, deceleration_rate)
