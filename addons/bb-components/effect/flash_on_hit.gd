@icon("./flash.svg")
class_name BBFlashOnHit
extends BBFlash

## Add a [BBFlash] effect to a [Node2D], triggered by a collision with a [BBHurtbox] component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/flash_on_hit.md

## The [BBHurtbox] component which notifies when to flash.
@export var hurtbox_node : BBHurtbox

func _ready() -> void:
	# Call [member BBFlash._ready].
	super()
	
	if hurtbox_node == null:
		hurtbox_node = get_parent() as BBHurtbox
	assert(hurtbox_node, ("No hurtbox_node:BBHurtbox component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a BBHurtbox component.") % [str(get_path())])

	hurtbox_node.damaged.connect(func(_damage: float): flash())

## Set the [BBHurtbox] node.
func set_hurtbox(new_hurtbox : BBHurtbox):
	hurtbox_node = new_hurtbox

## Get the [BBHurtbox] node.
func get_hurtbox() -> BBHurtbox:
	return hurtbox_node
