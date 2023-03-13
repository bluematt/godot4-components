extends "res://addons/bb-components/base_component.gd"
class_name BBRotate

## Rotate a [Node2D] at a constant angular speed.

@export_category("RotateComponent")

## The node to rotate.
@export var object_node : Node2D:
	set=set_object_node, get=get_object_node

## Set [member object_node].
func set_object_node(_node : Node2D) -> void: object_node = _node

## Get [member object_node].
func get_object_node() -> Node2D: return object_node

## Rotation speed (degrees per second).
@export_range(-1080.0, 1080.0, 0.01, "suffix:°/s") var rotation_speed := 0.0:
	set=set_rotation_speed, get=get_rotation_speed

## Set [member rotation_speed].
func set_rotation_speed(_rotation_speed : float) -> void:
	rotation_speed = _rotation_speed

## Get [member rotation_speed].
func get_rotation_speed() -> float:
	return rotation_speed
	
func _ready() -> void:
	if not object_node:
		object_node = get_parent()

	assert(object_node, ("No object_node:Node2D component specified in %s. " +
		"Select one, or reparent this component as a child of a Node2D node.")
		% [str(get_path())])

func _process(delta: float) -> void:
	if enabled:
		object_node.rotation_degrees += rotation_speed * delta
