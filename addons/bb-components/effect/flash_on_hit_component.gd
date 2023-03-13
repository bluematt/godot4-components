@icon("./flash_component.svg")
class_name FlashOnHitComponent
extends FlashComponent

## Add a [FlashComponent] effect to a [Node2D], triggered by a collision between a [BBHitbox] and a [BBHurtbox].

## The [BBHurtbox] component which notifies when to flash.
@export var hurtbox_component : BBHurtbox:
	set(hurtbox_component_):
		hurtbox_component = hurtbox_component as BBHurtbox
	get:
		return hurtbox_component

func _ready() -> void:
	super()
	
	# Make sure a [member hurtbox_component] is specified
	assert(hurtbox_component, "No hurtbox_node:BBHurtbox component specified in %s." % [str(get_path())])

	# Connect the [member hurtbox_component]'s damaged signal.
	hurtbox_component.damaged.connect(_on_hurtbox_damaged)

# Callback when the [member hurtbox_component] is damaged.
func _on_hurtbox_damaged(_damage: float) -> void:
	flash()
