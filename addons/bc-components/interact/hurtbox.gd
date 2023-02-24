@icon("./hurtbox.svg")
class_name BBHurtbox
extends Area2D

## A simple hurtbox component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/hurtbox.md

## The [StatHealth] to manipulate.
@export var health_stat_node:BBHealth

signal damaged(amount: float)

func _ready() -> void:
	if health_stat_node == null:
		health_stat_node = get_parent() as BBHealth
	assert(health_stat_node, ("No health_stat_node:BBHealth component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBHealth component.") % [str(get_path())])

func damage(amount: float) -> void:
	health_stat_node.damage(amount)
	damaged.emit(amount)
