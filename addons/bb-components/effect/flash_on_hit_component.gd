@icon("./flash_component.svg")
class_name FlashOnHitComponent
extends FlashComponent

## Add a [FlashComponent] effect to a [Node2D], triggered by a collision between a [HitboxComponent] and a [HurtboxComponent].
##
## Attach the component to a [Node2D].  When a valid collision occurs to the specified [HitboxComponent], the [Node2D] will have a flash effect applied.
## Optionally, with [member flash_on_damage_only] enabled, the flash effect will only take effect if damage is applied.

## The [HurtboxComponent] component which notifies when to flash.
@export var hurtbox_component: HurtboxComponent

## Only flash if damage > 0 was inflicted.
@export var flash_on_damage_only := false

func _ready() -> void:
	super()
	
	# Make sure a [member hurtbox_component] is specified
	assert(hurtbox_component, "No hurtbox_node:HurtboxComponent specified in %s." % [str(get_path())])

	# Connect the [member hurtbox_component]'s damaged signal.
	hurtbox_component.damaged.connect(_on_hurtbox_damaged)

# Callback when the [member hurtbox_component] is damaged.
func _on_hurtbox_damaged(_damage: float) -> void:
	if not flash_on_damage_only or (flash_on_damage_only and _damage > 0.0):
		flash()
