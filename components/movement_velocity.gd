class_name MovementVelocity
extends Node

## Controls [member CharacterBody2D.velocity], applying a maximum speed with acceleration and deceleration coefficients.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/MovementVelocity.md

## The [CharacterBody2D] to move.
@export var character_node:CharacterBody2D

## The maximum speed, in pixels per second.
@export var max_speed := 64.0

## The acceleration coefficient (0.0-1.0).
## 1.0 is instantaneous (full speed at t=0).
@export_range(0.0, 1.0, 0.001) var acceleration_coefficient := 1.0

## The acceleration coefficient (0.0-1.0).
## 1.0 is instantaneous (full stop at t=0).
@export_range(0.0, 1.0, 0.001) var deceleration_coefficient := 1.0

## The direction of the velocity.
var direction := Vector2.ZERO

func _ready() -> void:
	if null == character_node:
		character_node = get_parent() as CharacterBody2D
	assert(character_node)
	
func _physics_process(_delta: float) -> void:
	if direction:
		__accelerate()
	else:
		if character_node.velocity:
			__decelerate()

	character_node.move_and_slide()
	
# Accelerate the [member character_node].
func __accelerate() -> void:
	var acceleration := max_speed * acceleration_coefficient
	var speed = direction.normalized() * max_speed
	character_node.velocity = character_node.velocity.move_toward(speed, acceleration)

# Decelerate the [member character_node].
func __decelerate() -> void:
	var deceleration := max_speed * deceleration_coefficient
	character_node.velocity = character_node.velocity.move_toward(Vector2.ZERO, deceleration)
