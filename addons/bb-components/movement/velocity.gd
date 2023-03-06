@icon("./velocity.svg")
class_name BBVelocity
extends Node

## Apply acceleration and deceleration to [member CharacterBody2D.velocity].

# The target velocity when decelerating.
const __DECELERATION_TARGET_VELOCITY := Vector2.ZERO

## The [CharacterBody2D] to move.
@export var character_node:CharacterBody2D:
	set=set_character_node, get=get_character_node

## Set [member character_node].
func set_character_node(_node : CharacterBody2D) -> void: character_node = _node

## Return [member character_node].
func get_character_node() -> CharacterBody2D: return character_node

## The maximum speed (pixels per second).
@export var max_speed := 64.0:
	set=set_max_speed, get=get_max_speed

## Set [member max_speed].
func set_max_speed(_max_speed : float) -> void: max_speed = max(0.0, _max_speed)

## Return [member max_speed].
func get_max_speed() -> float: return max_speed

## The acceleration coefficient (0.0-1.0).  1.0 is instantaneous (full speed at
## [i]t=0[/i]).
@export_range(0.0, 1.0) var acceleration_coefficient := 1.0:
	set=set_acceleration_coefficient, get=get_acceleration_coefficient

## Set [member acceleration_coefficient].
func set_acceleration_coefficient(_acceleration_coefficient : float) -> void:
	acceleration_coefficient = clampf(_acceleration_coefficient, 0.0, 1.0)

## Return [member acceleration_coefficient].
func get_acceleration_coefficient() -> float: return acceleration_coefficient

## The deceleration coefficient (0.0-1.0).  1.0 is instantaneous (full stop at
## [i]t=0[/i]).
@export_range(0.0, 1.0) var deceleration_coefficient := 1.0:
	set=set_deceleration_coefficient, get=get_deceleration_coefficient

## Set [member deceleration_coefficient].
func set_deceleration_coefficient(_deceleration_coefficient : float) -> void:
	deceleration_coefficient = clampf(_deceleration_coefficient, 0.0, 1.0)

## Return [member deceleration_coefficient].
func get_deceleration_coefficient() -> float: return deceleration_coefficient

## The direction of the velocity.
var direction := Vector2.ZERO:
	set=set_direction, get=get_direction

## Set the current direction.
func set_direction(_direction : Vector2) -> void: direction = _direction

## Return the current direction.
func get_direction() -> Vector2: return direction

func _ready() -> void:
	if null == character_node:
		character_node = get_parent() as CharacterBody2D
	assert(character_node, ("No character_node:CharacterBody2D node " +
		"specified in %s. Select one, or reparent this component as a child " +
		"of a CharacterBody2D node.") % [str(get_path())])

func _physics_process(_delta : float) -> void:
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

## Set the current direction's [code]x[/code] component.
func set_x_direction(x : float) -> void:
	set_direction(Vector2(x, direction.y))

## Set the current direction's [code]y[/code] component.
func set_y_direction(y : float) -> void:
	set_direction(Vector2(direction.x, y))

## Set the current direction's [code]x[/code] component, reset the
## [code]y[/code] component.
func set_x_direction_only(x : float) -> void:
	set_direction(Vector2(x, 0.0))

## Set the current direction's [code]y[/code] component, reset the
## [code]x[/code] component.
func set_y_direction_only(y : float) -> void:
	set_direction(Vector2(0.0, y))
