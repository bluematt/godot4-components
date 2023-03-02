@icon("./align_to_velocity.svg")
class_name BBAlignToVelocity
extends Node

## Align a node to a velocity.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/align_to_velocity.md

## The [CharacterBody2D] to align.
@export var character_node:CharacterBody2D

## The [BBVelocity] component to align to.
@export var velocity_node:BBVelocity

## A rotational offset, in degrees.
@export_range(-360.0,360.0) var offset := 90.0

## The smoothing to be applied to the rotation.
@export_range(0.0, 1.0) var smoothing := 1.0

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
	
	if velocity_node == null:
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
