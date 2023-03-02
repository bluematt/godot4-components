@icon("./flash.svg")
class_name BBFlashOnHit
extends Node

## Add a flash effect to a [Node2D], triggered by a collision with a [BBHurtbox] component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/flash_on_hit.md

## The node to flash.
@export var target_node : Node2D

## The [BBHurtbox] component which notifies when to flash.
@export var hurtbox_node : Node2D

## The duration of the flash (in seconds).
@export var flash_duration := 0.2

## The node's default color modulation.
@export var default_modulation := Color.WHITE

## The node's flash color modulation.
@export var flash_modulation := Color.RED

## The saturation multiplier for the flash color.
@export var saturation := 1.0

## The [BBFlash] component used to flash the [member target_node].
@onready var __flash:BBFlash

func _ready() -> void:
	if target_node == null:
		target_node = get_parent() as Node2D
	assert(target_node, ("No target_node:Node2D node specified in %s. Select " +
		"one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])

	if hurtbox_node == null:
		hurtbox_node = get_parent() as BBHurtbox
	assert(hurtbox_node, ("No hurtbox_node:BBHurtbox component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBHurtbox component.") % [str(get_path())])

	__flash = BBFlash.new()
	__flash.target_node = target_node
	__flash.flash_duration = flash_duration
	__flash.default_modulation = default_modulation
	__flash.flash_modulation = flash_modulation
	__flash.saturation = saturation

	add_child(__flash)

	hurtbox_node.damaged.connect(func(_damage: float):
		__flash.flash())
