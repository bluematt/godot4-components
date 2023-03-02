@icon("./velocity.svg")
class_name BBVelocity
extends Node

## Control [member CharacterBody2D.velocity], applying a maximum speed with acceleration and deceleration coefficients.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/velocity.md

# The target velocity when decelerating.
const __DECELERATION_TARGET_VELOCITY := Vector2.ZERO

## The [CharacterBody2D] to move.
@export var character_node:CharacterBody2D

## The maximum speed (pixels per second).
@export var max_speed := 64.0

## The acceleration coefficient (0.0-1.0).  1.0 is instantaneous (full speed at
## [i]t=0[/i]).
@export_range(0.0, 1.0) var acceleration_coefficient := 1.0

## The deceleration coefficient (0.0-1.0).  1.0 is instantaneous (full stop at
## [i]t=0[/i]).
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

## Set [member max_speed].
func set_character(node : CharacterBody2D) -> void:
	character_node = node

## Return [member max_speed].
func get_character() -> CharacterBody2D:
	return character_node

## Set [member max_speed].
func set_max_speed(max_speed : float) -> void:
	max_speed = max(0, max_speed)

## Return [member max_speed].
func get_max_speed() -> float:
	return max_speed

## Set [member acceleration_coefficient].
func set_acceleration(acceleration : float) -> void:
	acceleration_coefficient = clampf(acceleration, 0.0, 1.0)

## Return [member acceleration_coefficient].
func get_acceleration() -> float:
	return acceleration_coefficient

## Set [member deceleration_coefficient].
func set_deceleration(deceleration : float) -> void:
	deceleration_coefficient = clampf(deceleration, 0.0, 1.0)

## Return [member deceleration_coefficient].
func get_deceleration() -> float:
	return deceleration_coefficient

## Set the current direction.
func set_direction(new_direction : Vector2) -> void:
	direction = new_direction

## Return the current direction.
func get_direction() -> Vector2:
	return direction

## Set the current direction's [code]x[/code] component.
func set_direction_x(x : float) -> void:
	set_direction(Vector2(x, direction.y))

## Set the current direction's [code]y[/code] component.
func set_direction_y(y : float) -> void:
	set_direction(Vector2(direction.x, y))

## Set the current direction's [code]x[/code] component, reset the
## [code]y[/code] component.
func set_direction_x_only(x : float) -> void:
	set_direction(Vector2(x, 0.0))

## Set the current direction's [code]y[/code] component, reset the
## [code]x[/code] component.
func set_direction_y_only(y : float) -> void:
	set_direction(Vector2(0.0, y))
