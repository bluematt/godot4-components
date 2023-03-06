@icon("./flash.svg")
class_name BBFlashOnHit
extends BBFlash

## Add a [BBFlash] effect to a [Node2D], triggered by a collision between a [BBHitbox] and a [BBHurtbox].

## The [BBHurtbox] component which notifies when to flash.
@export var hurtbox_node : BBHurtbox:
	set=set_hurtbox_node, get=get_hurtbox_node

## Set the [BBHurtbox] node.
func set_hurtbox_node(_node : BBHurtbox): hurtbox_node = _node

## Get the [BBHurtbox] node.
func get_hurtbox_node() -> BBHurtbox: return hurtbox_node

func _ready() -> void:
	super()
	
	if null == hurtbox_node:
		hurtbox_node = get_parent() as BBHurtbox
	assert(hurtbox_node, ("No hurtbox_node:BBHurtbox component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBHurtbox component.") % [str(get_path())])

	hurtbox_node.damaged.connect(func(_damage: float): flash())

