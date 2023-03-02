@icon("./hurtbox.svg")
class_name BBHurtbox
extends Area2D

## A simple hurtbox component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/hurtbox.md

## Emitted when hit by a [BBHitbox].
signal damaged(amount: float)

## The [BBHealth] to manipulate.
@export var health_node:BBHealth

func _ready() -> void:
	if null == health_node:
		health_node = get_parent() as BBHealth
	assert(health_node, ("No health_node:BBHealth component specified in %s." +
		"Select one, or reparent this component as a child of a BBHealth " +
		"component.") % [str(get_path())])

## Apply some damage to the [BBHealth] component.
func damage(amount: float) -> void:
	health_node.damage(amount)
	damaged.emit(amount)

## Set the health node.
func set_health_node(node : BBHealth) -> void:
	health_node = node

## Get the health node.
func get_health_node() -> BBHealth:
	return health_node
