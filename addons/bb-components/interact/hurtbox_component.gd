@icon("./hurtbox_component.svg")
extends Area2D
class_name HurtboxComponent

## Receive damage from a [HitboxComponent] component.

## Emitted when hit by a [HitboxComponent].
signal damaged(amount: float)

## The [HealthComponent] to manipulate.
@export var health_component: HealthComponent

func _ready() -> void:
	# Make sure a [member health_component] is specified
	assert(health_component, "No health_component:HealthComponent specified in %s." % [str(get_path())])

## Apply some damage to the [HealthComponent] component.
func apply_damage(amount: float) -> void:
	health_component.damage(amount)
	damaged.emit(amount)
