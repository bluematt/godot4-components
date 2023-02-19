@icon("res://icons/movement_velocity.svg")
class_name MovementVelocity
extends Node

## Controls [member CharacterBody2D.velocity], applying a maximum speed with acceleration and deceleration coefficients.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementVelocity.md

# The target velocity when decelerating.
const __DECELERATION_TARGET_VELOCITY := Vector2.ZERO

## The [CharacterBody2D] to move.
@export var character_node:CharacterBody2D

## The maximum speed, in pixels per second.
@export var max_speed := 64.0

## The acceleration coefficient (0.0-1.0).
## 1.0 is instantaneous (full speed at t=0).
@export_range(0.0, 1.0) var acceleration_coefficient := 1.0

## The deceleration coefficient (0.0-1.0).
## 1.0 is instantaneous (full stop at t=0).
@export_range(0.0, 1.0) var deceleration_coefficient := 1.0

## The direction of the velocity.
var direction := Vector2.ZERO

func _ready() -> void:
	if null == character_node:
		character_node = get_parent() as CharacterBody2D
	assert(character_node, ("No character_node:CharacterBody2D node " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a CharacterBody2D node.") % [str(get_path())])

func _physics_process(_delta: float) -> void:
	# Accelerate if we have somewhere to go.
	if direction: # bool(Vector2.ZERO) == false
		__accelerate()
	else:
		# Decelerate if we're still moving.
		if character_node.velocity:
			__decelerate()

	character_node.move_and_slide()
	
# Accelerate the [member character_node].
func __accelerate() -> void:
	var acceleration_rate := max_speed * acceleration_coefficient
	var speed = direction.normalized() * max_speed
	character_node.velocity = character_node.velocity.move_toward(speed, acceleration_rate)

# Decelerate the [member character_node].
func __decelerate() -> void:
	var deceleration_rate := max_speed * deceleration_coefficient
	character_node.velocity = \
		character_node.velocity.move_toward(__DECELERATION_TARGET_VELOCITY, deceleration_rate)
