@icon("./hurtbox.svg")
class_name BBHurtbox
extends Area2D

## Receive damage from a [BBHitbox] component.

## Emitted when hit by a [BBHitbox].
signal damaged(amount: float)

## The [BBHealth] to manipulate.
@export var health_node:BBHealth:
	set=set_health_node, get=get_health_node

## Set the health node.
func set_health_node(_node : BBHealth) -> void: health_node = _node

## Get the health node.
func get_health_node() -> BBHealth: return health_node

func _ready() -> void:
	if null == health_node:
		health_node = get_parent() as BBHealth
	assert(health_node, ("No health_node:BBHealth component specified in %s." +
		"Select one, or reparent this component as a child of a BBHealth " +
		"component.") % [str(get_path())])
		
## Apply some damage to the [BBHealth] component.
func apply_damage(amount: float) -> void:
	health_node.damage(amount)
	damaged.emit(amount)
