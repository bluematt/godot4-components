@icon("./align_to_velocity.svg")
class_name BBAlignToVelocity
extends Node

## Align a [CharacterBody2D] to a [BBVelocity].
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/align_to_velocity.md

## The [CharacterBody2D] to align.
@export var character_node:CharacterBody2D

## The [BBVelocity] component to align to.
@export var velocity_node:BBVelocity

## A rotational offset angle (in degrees).
@export_range(-360.0,360.0) var offset := 90.0:
	set(o):
		offset = clampf(o, -360.0, 360.0)

## The smoothing to be applied to the rotation.
@export_range(0.0, 1.0) var smoothing := 1.0:
	set(s):
		smoothing = clampf(s, 0.0, 1.0)

## Whether the component is enabled.
@export var enabled := true

# The interpolated rotation.
var __rotation:float

func _ready() -> void:
	if null == character_node:
		character_node = get_parent() as CharacterBody2D
	assert(character_node, ("No character_node:CharacterBody2D node " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a CharacterBody2D node.") % [str(get_path())])
	
	if null == velocity_node:
		velocity_node = get_parent() as BBVelocity
	assert(velocity_node, ("No velocity_node:BBVelocity component " + 
		"specified in %s. Select one, or reparent this component as a child "
		+ "of a BBVelocity component.") % [str(get_path())])

	__rotation = character_node.rotation

func _physics_process(_delta: float) -> void:
	if enabled:
		if velocity_node.get_direction():
			__rotation = lerp_angle(__rotation, 
				velocity_node.get_direction().angle() + 
				deg_to_rad(offset), smoothing)

			character_node.rotation = __rotation

## Set the [CharacterBody2D].
func set_character(new_character : CharacterBody2D) -> void:
	character_node = new_character

## Get the [CharacterBody2D].
func get_character() -> CharacterBody2D:
	return character_node

## Set the [BBVelocity].
func set_velocity(new_velocity : BBVelocity) -> void:
	velocity_node = new_velocity

## Get the [BBVelocity].
func get_velocity() -> BBVelocity:
	return velocity_node

## Set the offset angle (in degrees).
func set_offset(new_offset : float) -> void:
	offset = new_offset

## Get the offset angle (in degrees).
func get_offset() -> float:
	return offset

## Set the smoothing.
func set_smoothing(new_smoothing : float) -> void:
	smoothing = new_smoothing

## Get the smoothing.
func get_smoothing() -> float:
	return smoothing

## Set enabled.
func set_enabled(is_enabled : bool) -> void:
	enabled = is_enabled

## Get enabled.
func get_enabled() -> bool:
	return enabled
	
## Enable the component.
func enable() -> void:
	set_enabled(true)

## Disable the component.	
func disable() -> void:
	set_enabled(false)

## Return whether the component is enabled.
func is_enabled() -> bool:
	return get_enabled()

## Return the current rotation (in degrees).
func get_rotation() -> float:
	return rad_to_deg(__rotation)
